import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/game_board.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameBoard(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
