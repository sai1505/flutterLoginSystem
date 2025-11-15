part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SigunUpRequest extends AuthEvent {
  late final String email;
  late final String name;
  late final String password;
  SigunUpRequest({
    required this.name,
    required this.email,
    required this.password,
  });
}

final class LoginRequest extends AuthEvent {
  late final String email;
  late final String password;

  LoginRequest({required this.email, required this.password});
}
