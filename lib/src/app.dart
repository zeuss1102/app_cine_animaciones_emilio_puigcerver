import 'package:flutter/material.dart';

import 'core/constants/constants.dart';
import 'features/movies/movies_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: AppTheme.light,
      home: const MoviesPage(),
    );
  }
}
