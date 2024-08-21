import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notiva/views/edit_note_screen.dart';
import 'package:notiva/views/notes_screen.dart';
import 'package:notiva/views/onboarding_screen.dart';
import 'package:notiva/views/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool onboarding = prefs.getBool('onboarding') ?? false;

  await Hive.initFlutter();
  await Hive.openBox('notes');
  runApp(Notiva( onboarding: onboarding));
}

// ignore: camel_case_types, use_key_in_widget_constructors
class Notiva extends StatelessWidget {
  final bool onboarding;
  const Notiva({super.key, this.onboarding = false});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        NotesScreen.id: (context) => const NotesScreen(),
        OnBoardingScreen.id: (context) => OnBoardingScreen(),
        SearchScreen.id: (context) => const SearchScreen(),
       EditNoteScreen.id: (context) => const EditNoteScreen(),
      
      },
      initialRoute: onboarding ? NotesScreen.id : OnBoardingScreen.id,
    );
  }
}
