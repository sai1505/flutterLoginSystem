part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSignupSuccess extends AuthState {
  late final String uid;
  AuthSignupSuccess({required this.uid});
}

final class AuthLoginSuccess extends AuthState {
  late final String msg;
  AuthLoginSuccess({required this.msg});
}

final class AuthError extends AuthState {
  late final String error;
  AuthError({required this.error});
}
