import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:tracker_app/expenses.dart';

// Generally start global variables with a naming scheme starting with 'k'
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(
    255,
    96,
    59,
    181,
  ),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness
      .dark, // Tells flutter to optimize this color theme/various shades to dark mode
  seedColor: const Color.fromARGB(
    255,
    5,
    99,
    125,
  ),
);

void main() {
  // Following commented out code FORCES vertical mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then(
  //   (fn) => runApp(const MyApp()),
  // );

  // But we'll do this instead
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        // Add a dark color theme option as well
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          // Default parameters for ALL cards used ANYWHERE in this app
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 14,
              ),
              titleMedium: TextStyle(
                fontWeight: FontWeight.normal,
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 12,
              ),
              titleSmall: TextStyle(
                fontWeight: FontWeight.normal,
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 10,
              ),
            ),
        dropdownMenuTheme: ThemeData().dropdownMenuTheme.copyWith(
              textStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 14,
              ),
            ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          // The top app bar has a background color
          backgroundColor: kColorScheme.onPrimaryContainer,
          // The top app bar has a foreground 'text' color
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          // Default parameters for ALL cards used ANYWHERE in this app
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        // No 'copyWith()' data method
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 14,
              ),
            ),
      ),
      home: const Expenses(),
      // themeMode: ThemeMode.system, // Depending on what the user does with their system regarding dark/light mode, that's what we'll do in the app
      // By default, themeMode is already ThemeMode.system
    );
  }
}
