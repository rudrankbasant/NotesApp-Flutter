import 'package:flutter/material.dart';
import 'package:notes/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:notes/providers/notes_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
          ChangeNotifierProvider(
              create: (context) => NotesProvider()
          ),
        ],
      child:MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(

              primary: const Color(0xFF1D1E33),
              secondary: const Color(0xFFEB1555),


            ),
          ),
          home: HomeScreen()
      ),
    );

  }
}

