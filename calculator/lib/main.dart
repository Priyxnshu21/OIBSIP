import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemChrome
import 'package:provider/provider.dart';

import 'package:calculator_app/core/calculator_service.dart';
import 'package:calculator_app/presentation/calculator_screen.dart';
import 'package:calculator_app/presentation/calculator_viewmodel.dart';
import 'package:calculator_app/presentation/utils/app_colors.dart';

void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations (portrait only for calculator)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    // Set system UI overlay style (for status bar icons)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarIconBrightness: Brightness.light, // White icons for dark background
        systemNavigationBarColor: Colors.black, // Black navigation bar
        systemNavigationBarIconBrightness: Brightness.light, // White icons for nav bar
      ),
    );
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide CalculatorService as a singleton, as it's stateless
        Provider<CalculatorService>(
          create: (_) => CalculatorService(),
        ),
        // Provide CalculatorViewModel, depending on CalculatorService
        ChangeNotifierProvider<CalculatorViewModel>(
          create: (context) => CalculatorViewModel(
            context.read<CalculatorService>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Apple Calculator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Define a dark theme to mimic iOS calculator
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.background,
          // Use a custom font if you want to replicate San Francisco more closely
          // Otherwise, system default sans-serif will be used.
          fontFamily: 'Helvetica Neue', // Example font, ensure it's in pubspec.yaml assets if custom
          useMaterial3: true, // Use Material 3 design features
        ),
        home: const CalculatorScreen(),
      ),
    );
  }
}