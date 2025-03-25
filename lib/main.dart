import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/error/failures.dart';
import 'features/auth/domain/entities/user.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khazana',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2196F3),
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF2196F3),
          secondary: const Color(0xFF2196F3),
          background: const Color(0xFF1A1A1A),
        ),
      ),
      home: BlocProvider(
        // TODO: Replace with proper repository implementation
        create: (context) => AuthBloc(
          signInUseCase: SignIn(FakeAuthRepository()),
          signUpUseCase: SignUp(FakeAuthRepository()),
        ),
        child: const LoginPage(),
      ),
    );
  }
}

// TODO: Replace with proper repository implementation
class FakeAuthRepository implements AuthRepository {
  @override
  Future<Either<Failure, User>> signIn(String email, String password) {
    // Implement actual authentication
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUp(String email, String password, String name) {
    // Implement actual authentication
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> signOut() {
    // Implement actual authentication
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() {
    // Implement actual authentication
    throw UnimplementedError();
  }
}
