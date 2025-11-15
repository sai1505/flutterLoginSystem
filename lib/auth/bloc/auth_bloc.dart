import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginsystem/storage/local_user_storage.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SigunUpRequest>((event, emit) async {
      final String name = event.name.trim();
      final String email = event.email.trim();
      final String password = event.password.trim();
      try {
        if (name.isEmpty) {
          emit(AuthError(error: "Name cannot be empty"));
          return;
        }

        if (name.length < 3) {
          emit(AuthError(error: "Name must be at least 3 characters"));
          return;
        }

        if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(name)) {
          emit(AuthError(error: "Name can contain only letters"));
          return;
        }

        if (email.isEmpty) {
          emit(AuthError(error: "Email cannot be empty"));
          return;
        }

        final emailRegex = RegExp(
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        );

        if (!emailRegex.hasMatch(email)) {
          emit(AuthError(error: "Enter a valid email address"));
          return;
        }

        if (password.isEmpty) {
          emit(AuthError(error: "Password cannot be empty"));
          return;
        }

        if (password.length < 8) {
          emit(AuthError(error: "Password must be at least 8 characters"));
          return;
        }

        // Must include uppercase, lowercase, digit, and special char
        final strongPassword = RegExp(
          r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$",
        );

        if (!strongPassword.hasMatch(password)) {
          emit(
            AuthError(
              error:
                  "Password must include:\n• Uppercase letter\n• Lowercase letter\n• Number\n• Special character",
            ),
          );
          return;
        }

        if (await LocalUserStorage.userExists(email)) {
          emit(AuthError(error: "Email already exists. Please log in."));
          return;
        }

        await LocalUserStorage.saveUser(
          name: name,
          email: email,
          password: password,
        );

        emit(AuthSuccess(uid: '$email Account created Successfully'));
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });
  }
}
