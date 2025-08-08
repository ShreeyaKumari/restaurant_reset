import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:restaurant_app/pages/HomePage.dart';
import 'package:restaurant_app/pages/SplashScreen.dart';
import 'package:restaurant_app/pages/cart_page.dart';
import 'package:restaurant_app/pages/navWraper.dart';

import 'package:restaurant_app/utils/colors.dart';
import 'package:restaurant_app/utils/cart_provider.dart';
import 'package:restaurant_app/utils/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: "Gourmet House",
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColors.background,
          secondary: AppColors.yellow,
          background: AppColors.textLight,
          surface: Colors.grey.shade100,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
        ),
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.dancingScript(
            fontSize: 24,
            color: AppColors.brown,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: GoogleFonts.aboreto(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          bodySmall: const TextStyle(fontSize: 12),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          secondary: AppColors.yellow,
          background: AppColors.textDark,
          surface: Colors.grey.shade900,
          onPrimary: Colors.black,
          onSecondary: Colors.white,
        ),
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.dancingScript(
            fontSize: 24,
            color: AppColors.yellow,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: GoogleFonts.aboreto(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          bodySmall: const TextStyle(fontSize: 12),
        ),
      ),
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => NavigationWrapper(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}
