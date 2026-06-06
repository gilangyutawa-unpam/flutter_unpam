import 'package:flutter/material.dart';
import 'package:flutter_unpam/page/beranda_page.dart';
import 'package:flutter_unpam/page/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;

  final List<Widget> pages = [BerandaPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // CherryToast safe
      builder: (context, child) {
        return Stack(children: [child!]);
      },

      home: Scaffold(
        body: pages[currentPage],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (i) => setState(() => currentPage = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
