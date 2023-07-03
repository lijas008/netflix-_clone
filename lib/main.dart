import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/application/download_bloc/downloads_bloc.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';

import 'package:netflix/constants/appcolors.dart';
import 'package:netflix/domain/core/di/injectable.dart';
import 'package:netflix/domain/downloads/models/downloads_model.dart';
import 'package:netflix/presentation/main_screen/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await configureInjection();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<DownloadsBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<FastLaughBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<HotAndNewBloc>(),
        ),
         BlocProvider(
          create: (context) => getIt<HomeBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
            fontFamily: GoogleFonts.montserrat().fontFamily,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: backgroundColor,
            textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.white),
                bodySmall: TextStyle(color: Colors.grey))),
        home: MainScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
