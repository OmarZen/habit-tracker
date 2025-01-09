import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:habit_tracker_hive/pages/home_page.dart';
import 'package:habit_tracker_hive/theme/theme_provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  // initialize Hive
  await Hive.initFlutter();

  // open the Hive box
  await Hive.openBox('Habit_Database');

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  void initialization() async {
    print('initializing');
    Future.delayed(const Duration(seconds: 2), () {
      print('initialized');
    });
    print('initializing done');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: Provider.of<ThemeProvider>(context).themeData);
  }
}
