import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'first_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  Map<String, String>? _loggedInUser;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  // Load user from SharedPreferences if already logged in
  void loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      setState(() {
        _loggedInUser = {
          'username': prefs.getString('username') ?? 'User',
          'email': prefs.getString('email') ?? '',
        };
        isLoading = false;
      });
    } else {
      setState(() {
        _loggedInUser = null;
        isLoading = false;
      });
    }
  }

  // Save user to SharedPreferences after login
  Future<void> saveUser(Map<String, String> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('username', user['username'] ?? '');
    await prefs.setString('email', user['email'] ?? '');

    setState(() {
      _loggedInUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nepflix',
      theme: ThemeData.dark(),

      // Show FirstScreen as the home page unconditionally
      home: const FirstScreen(),
    );
  }
}