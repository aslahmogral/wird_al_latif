import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wird_al_latif/home_screen.dart';
import 'package:wird_al_latif/model/wird_model.dart';
import 'package:wird_al_latif/provider/wird_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<WirdModel>? wirdList = [];

  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      wirdList: wirdList,
                    )
                // HomeScreen()
                )));
    super.initState();
  }

  getWirdData() async {
    final _wirdProvider =
        await Provider.of<WirdProvider>(context, listen: false);
    await _wirdProvider.loadLocalJsonData();
    wirdList = await _wirdProvider.wirddata;
    // wirdListLength = _wirdProvider.wirddata!.length;
    // print(_wirdProvider.wirddata);
    print("splashscreen initstate");
    print(wirdList);
  }

  @override
  Widget build(BuildContext context) {
    getWirdData();

    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(child: Container()),
            Image.asset('asset/bismillah.png'),
            Lottie.asset(
              'asset/wird.json',
            ),
            Expanded(child: Container()),
          ],
        ));
  }
}
