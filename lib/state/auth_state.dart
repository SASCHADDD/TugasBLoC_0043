part of '../bloc/auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String email;
  AuthAuthenticated({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthRegistered extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}