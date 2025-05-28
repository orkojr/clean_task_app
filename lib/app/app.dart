import 'package:clean_task_app/app/binding/appbinding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes/app_pages.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ORKO Task App',
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,
    );
  }
}

// 🎨 Light Theme
final _lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  textTheme: GoogleFonts.poppinsTextTheme(),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),
);

// 🌙 Dark Theme
final _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.black,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blueAccent,
  ),
);
