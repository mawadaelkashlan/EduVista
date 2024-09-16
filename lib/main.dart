import 'package:edu_vista/features/home/blocs/course/course_bloc.dart';
import 'package:edu_vista/features/home/blocs/lecture/lecture_bloc.dart';
import 'package:edu_vista/features/auth/cubit/auth/auth_cubit.dart';
import 'package:edu_vista/edu_vista.dart';
import 'package:edu_vista/firebase_options.dart';
import 'package:edu_vista/services/pref_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesService.init();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Failed to initialize Firebase : $e');
  }
  await dotenv.load(fileName: ".env");
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (ctx) => AuthCubit()),
      BlocProvider(create: (ctx) => CourseBloc()),
      BlocProvider(create: (ctx) => LectureBloc()),
    ],
    child: const EduVista(),
  ));
}