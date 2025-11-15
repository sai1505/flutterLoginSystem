part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {
  late final uid;
  AuthSuccess({required this.uid});
}

final class AuthError extends AuthState {
  late final String error;
  AuthError({required this.error});
}
