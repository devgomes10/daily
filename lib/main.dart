import 'package:daily/models/journal.dart';
import 'package:daily/screens/add_journal_screen/add_journal_screen.dart';
import 'package:daily/services/journal_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());

  JournalService service = JournalService();
  service.register(Journal.empty());
  // service.get();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Journal',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: GoogleFonts.bitterTextTheme(),
      ),
      initialRoute: "home",
      routes: {
        "home": (context) => const HomeScreen(),
      },
      onGenerateRoute: (setting) {
        if (setting.name == 'add-journal') {
          final Journal journal = setting.arguments as Journal;
          return MaterialPageRoute(
            builder: (context) {
              return AddJournalScreen(journal: journal);
            },
          );
        }
      },
    );
  }
}
