import 'package:flutter/material.dart';
import 'package:my_website/src/theme.dart';
import 'package:provider/provider.dart';
import 'pages/navigation_page.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const NavigationPage();
  }
}



