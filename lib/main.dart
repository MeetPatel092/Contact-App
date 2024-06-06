import 'package:contact_hub/provider/contact_provider.dart';
import 'package:contact_hub/provider/hide_provider.dart';
import 'package:contact_hub/provider/search_provider.dart';
import 'package:contact_hub/provider/sterpper_step.dart';
import 'package:contact_hub/provider/theme_provider.dart';
import 'package:contact_hub/view/detailpage.dart';
import 'package:contact_hub/view/hidepage.dart';
import 'package:contact_hub/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StepperProvider()),
        ChangeNotifierProvider(create: (context) => ContactProvider()),
        ChangeNotifierProvider(create: (context) => HideProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const Homepage(),
        'hide': (context) => const HidePage(),
        'detail': (context) => const Detailpage(),
      },
    );
  }
}
