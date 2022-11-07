import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wird_al_latif/home_screen.dart';
import 'package:wird_al_latif/provider/wird_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return WirdProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wird Al Latif',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
