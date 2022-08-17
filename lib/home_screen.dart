import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wird_al_latif/provider/wird_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int nextIndex = 0;
  bool endMessage = false;
  var count = 0;

  prevButtonMethod(WirdProvider wirdData) {
    if (nextIndex > 0 && nextIndex < wirdData.getWirdList.length) {
      setState(() {
        nextIndex--;
        print(nextIndex);
      });
    } else if (nextIndex > wirdData.getWirdList.length - 1) {
      setState(() {
        nextIndex = wirdData.getWirdList.length;
        nextIndex--;
        print(nextIndex);
        endMessage = false;
      });
    }
  }

  countButtonMethod(WirdProvider wirdData) {
    if (endMessage) {
      return null;
    } else {
      if (count < wirdData.getWirdList[nextIndex].count - 1) {
        setState(() {
          count++;
        });
      } else if (nextIndex >= wirdData.getWirdList.length) {
        setState(() {
          endMessage = true;
        });
      } else {
        setState(() {
          nextIndex++;

          count = 0;
        });
      }
    }
  }

  nextButtonMethod(WirdProvider wirdData) {
    nextIndex++;

    if (nextIndex < wirdData.getWirdList.length - 1) {
      setState(() {
        print('1: $nextIndex');
      });
    } else if (nextIndex >= wirdData.getWirdList.length) {
      setState(() {
        endMessage = true;
        nextIndex == wirdData.getWirdList.length + 2;
        print('2: $nextIndex');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WirdProvider>(
        builder: (BuildContext context, wirdData, Widget? child) {
      var percentage = nextIndex / wirdData.getWirdList.length * 100;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Wirdul-Latif '),
          actions: [
            InkWell(
              onDoubleTap: (() {
                setState(() {
                  nextIndex = 0;
                });
              }),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(percentage > 100
                        ? '100.0%'
                        : '${percentage.roundToDouble().toString()}%'),
                    Text('Reset')
                  ],
                ),
              ),
            )
          ],
          centerTitle: true,
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton.extended(
                    onPressed: () {
                      prevButtonMethod(wirdData);
                    },
                    label: const Text('  Prev  ')),
                FloatingActionButton.large(
                    onPressed: () {
                      countButtonMethod(wirdData);
                    },
                    child: Text(endMessage
                        ? 'finished'
                        : '$count /${wirdData.getWirdList[nextIndex].count.toString()}')),
                FloatingActionButton.extended(
                    onPressed: () {
                      nextButtonMethod(wirdData);
                    },
                    label: const Text('  Next  ')),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              arabicTextWidget(context, wirdData),
              SizedBox(
                height: 150,
              )
            ],
          ),
        ),
      );
    });
  }

  Center arabicTextWidget(BuildContext context, WirdProvider wirdData) {
    return Center(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Card(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: endMessage
                        ? Text('over',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ))
                        : Text(
                            wirdData.getWirdList[nextIndex].arabic,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                  ),),
            ),));
  }
}
