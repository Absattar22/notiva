import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notiva/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notiva/models/note_model.dart';
import 'package:notiva/simple_bloc_observer.dart';
import 'package:notiva/views/edit_note_screen.dart';
import 'package:notiva/views/notes_screen.dart';
import 'package:notiva/views/onboarding_screen.dart';
import 'package:notiva/views/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool onboarding = prefs.getBool('onboarding') ?? false;


  Bloc.observer = SimpleBlocObserver();
  await Hive.initFlutter();
  await Hive.openBox('notes');
  Hive.registerAdapter(NoteModelAdapter());
  runApp(Notiva( onboarding: onboarding));
}

// ignore: camel_case_types, use_key_in_widget_constructors
class Notiva extends StatelessWidget {
  final bool onboarding;
  const Notiva({super.key, this.onboarding = false});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context) => AddNoteCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          NotesScreen.id: (context) => const NotesScreen(),
          OnBoardingScreen.id: (context) => OnBoardingScreen(),
          SearchScreen.id: (context) => const SearchScreen(),
         EditNoteScreen.id: (context) => const EditNoteScreen(),
        
        },
        initialRoute: onboarding ? NotesScreen.id : OnBoardingScreen.id,
      ),
    );
  }
}
