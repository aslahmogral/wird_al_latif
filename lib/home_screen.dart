import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wird_al_latif/provider/wird_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List wirdList = Provider.of<WirdProvider>(context).getWirdList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('bismillah'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {},
              child: Text('${wirdList[12].arabic} ${wirdList[12].count}'))
        ],
      ),
    );
  }
}
