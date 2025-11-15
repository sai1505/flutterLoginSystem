import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginsystem/auth/bloc/auth_bloc.dart';
import 'package:loginsystem/screens/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Modern App',
        themeMode: ThemeMode.system,

        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          textTheme: const TextTheme(
            headlineMedium: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
            bodyLarge: TextStyle(fontSize: 16, height: 1.4),
          ),
          scaffoldBackgroundColor: Colors.grey[50],
        ),

        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          textTheme: const TextTheme(
            headlineMedium: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
            bodyLarge: TextStyle(fontSize: 16, height: 1.4),
          ),
        ),

        home: const SignupPage(), // Keep your screen
      ),
    );
  }
}
