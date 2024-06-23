import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:training_app/screens/new_workout_selection_screen.dart';
import 'package:training_app/screens/workouts_list_screen.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  surface: const Color.fromARGB(255, 56, 49, 66),
  onPrimary: Colors.white,
  onPrimaryContainer: Colors.white,
  primary: Colors.white,
);

final theme = ThemeData().copyWith(
  canvasColor: const Color.fromARGB(255, 56, 49, 66),
  shadowColor: Colors.transparent,
  scaffoldBackgroundColor: colorScheme.surface,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.ubuntuCondensed(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 13,
    ),
  ),
);

void main() {
  runApp(const ProviderScope(
    child: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: MaterialApp(
        title: 'Traning App',
        theme: theme,
        home: const WorkoutsListScreen(),
      ),
    );
  }
}
