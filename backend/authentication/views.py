import random
import string

from datetime import timedelta
from django.utils import timezone
from django.contrib.auth import authenticate

from rest_framework.views import APIView
from rest_framework import status, generics
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication

from .models import User, OTP
from .serializers import (
    UserSerializer, RegisterSerializer, SocialAuthSerializer, 
    SendOTPSerializer, VerifyOTPSerializer, ResetPasswordSerializer, EditProfileSerializer
)

from core.views import BaseAPIView
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema

# Create your views here.

class UserRegistrationView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        try:
            serializer = RegisterSerializer(data=request.data)
            if not serializer.is_valid():
                return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

            user = serializer.save()
            refresh = RefreshToken.for_user(user)

            return Response({
                'user': UserSerializer(user).data,
                'refresh': str(refresh),
                'access': str(refresh.access_token),
            }, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response(str(e), status=status.HTTP_400_BAD_REQUEST)

class UserLoginView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        try:
            email = request.data.get('email')
            password = request.data.get('password')

            print(f"Email: {email}")
            print(f"Password: {password}")

            if not email or not password:
                return Response("Email and password are required", status=status.HTTP_400_BAD_REQUEST)

            user = authenticate(email=email, password=password)
            if not user:
                return Response("Invalid email or password", status=status.HTTP_400_BAD_REQUEST)

            refresh = RefreshToken.for_user(user)

            # Update last login
            user.last_login = timezone.now()
            user.save(update_fields=['last_login'])

            return Response({
                'user': UserSerializer(user).data,
                'refresh': str(refresh),
                'access': str(refresh.access_token),
            })
        except Exception as e:
            return Response(str(e), status=status.HTTP_400_BAD_REQUEST)

class UserProfileView(BaseAPIView):
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request):
        try:
            serializer = UserSerializer(request.user)
            return Response(serializer.data)
        except Exception as e:
            return Response(str(e), status=status.HTTP_400_BAD_REQUEST)

    def patch(self, request):
        try:
            serializer = UserSerializer(request.user, data=request.data, partial=True)
            if not serializer.is_valid():
                return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

            serializer.save()
            return Response(serializer.data)
        except Exception as e:
            return Response(str(e), status=status.HTTP_400_BAD_REQUEST)

class UserLogoutView(BaseAPIView):
    def post(self, request):
        try:
            refresh_token = request.data.get('refresh')
            if not refresh_token:
                return Response("Refresh token is required", status=status.HTTP_400_BAD_REQUEST)

            token = RefreshToken(refresh_token)
            token.blacklist()

            return Response({"detail": "Successfully logged out."})
        except Exception as e:
            return Response(str(e), status=status.HTTP_400_BAD_REQUEST)

class GoogleSignupView(APIView):
    permission_classes = (AllowAny,)
    serializer_class = SocialAuthSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)

        # Here you would verify the token with Google
        # and get user info from Google's response
        # This is a placeholder for the actual implementation

        # For demo purposes, creating/getting user with dummy data
        email = "example@gmail.com"  # This would come from Google
        user, created = User.objects.get_or_create(
            email=email,
            defaults={
                'username': email.split('@')[0],
                'is_email_verified': True,
                'google_id': 'google_id_here'  # This would come from Google
            }
        )

        refresh = RefreshToken.for_user(user)
        return Response({
            'user': UserSerializer(user).data,
            'refresh': str(refresh),
            'access': str(refresh.access_token),
        })

class AppleSignupView(APIView):
    permission_classes = (AllowAny,)
    serializer_class = SocialAuthSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)

        # Here you would verify the token with Apple
        # and get user info from Apple's response
        # This is a placeholder for the actual implementation

        # For demo purposes, creating/getting user with dummy data
        email = "example@icloud.com"  # This would come from Apple
        user, created = User.objects.get_or_create(
            email=email,
            defaults={
                'username': email.split('@')[0],
                'is_email_verified': True,
                'apple_id': 'apple_id_here'  # This would come from Apple
            }
        )

        refresh = RefreshToken.for_user(user)
        return Response({
            'user': UserSerializer(user).data,
            'refresh': str(refresh),
            'access': str(refresh.access_token),
        })

class SendOTPView(APIView):
    permission_classes = (AllowAny,)
    serializer_class = SendOTPSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        email = serializer.validated_data['email']

        # Generate OTP
        otp = ''.join(random.choices(string.digits, k=6))
        expires_at = timezone.now() + timedelta(minutes=10)

        # Save OTP
        OTP.objects.create(
            email=email,
            otp=otp,
            expires_at=expires_at
        )

        # Here you would send the OTP via email
        # This is a placeholder for the actual email sending

        return Response({
            'message': 'OTP sent successfully',
            'email': email
        })

class VerifyOTPView(APIView):
    permission_classes = (AllowAny,)
    serializer_class = VerifyOTPSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)

        email = serializer.validated_data['email']
        otp = serializer.validated_data['otp']

        otp_obj = OTP.objects.filter(
            email=email,
            otp=otp,
            is_used=False,
            expires_at__gt=timezone.now()
        ).first()

        if not otp_obj:
            return Response(
                {'error': 'Invalid or expired OTP'},
                status=status.HTTP_400_BAD_REQUEST
            )

        # Mark OTP as used
        otp_obj.is_used = True
        otp_obj.save()

        # Mark user email as verified if exists
        user = User.objects.filter(email=email).first()
        if user:
            user.is_email_verified = True
            user.save()

        return Response({'message': 'OTP verified successfully'})

class ResetPasswordView(APIView):
    permission_classes = (AllowAny,)
    serializer_class = ResetPasswordSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)

        email = serializer.validated_data['email']
        password = serializer.validated_data['password']

        user = User.objects.filter(email=email).first()
        if not user:
            return Response(
                {'error': 'User not found'},
                status=status.HTTP_404_NOT_FOUND
            )

        user.set_password(password)
        user.save()

        return Response({'message': 'Password reset successfully'})

class EditProfileView(generics.UpdateAPIView):
    permission_classes = (IsAuthenticated,)
    serializer_class = EditProfileSerializer

    def get_object(self):
        return self.request.user

    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(
            instance,
            data=request.data,
            partial=partial,
            context={'request': request}
        )
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)
        return Response(UserSerializer(instance).data)

    @swagger_auto_schema(
        operation_description="Partially update user profile",
        request_body=openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                'username': openapi.Schema(type=openapi.TYPE_STRING, description='New username'),
                'bio': openapi.Schema(type=openapi.TYPE_STRING, description='User bio'),
                'profile_picture': openapi.Schema(type=openapi.TYPE_STRING, format='binary', description='Profile picture')
            },
            example={
                'username': 'new_username',
                'bio': 'Updated bio about bird watching'
            }
        ),
        responses={
            200: openapi.Response(
                description="Profile updated successfully",
                examples={
                    "application/json": {
                        "id": 1,
                        "email": "user@example.com",
                        "username": "new_username",
                        "bio": "Updated bio about bird watching",
                        "profile_picture": "https://example.com/profile.jpg"
                    }
                }
            ),
            400: "Bad Request - Invalid input data",
            401: "Unauthorized - Authentication credentials were not provided"
        }
    )
    def patch(self, request, *args, **kwargs):
        return self.partial_update(request, *args, **kwargs)
