import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wird_al_latif/provider/wird_provider.dart';
import 'package:wird_al_latif/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int nextIndex = 0;
  bool endMessage = false;
  var count = 0;
  double percentage = 0;

  prevButtonMethod(WirdProvider wirdData) {
    count = 0;

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
      print('end message');
      return null;
    } else {
      if (count < wirdData.getWirdList[nextIndex].count - 1) {
        print('end message 1111');

        setState(() {
          count++;
        });
      } else {
        if (nextIndex == wirdData.getWirdList.length - 1) {
          setState(() {
            endMessage = true;
          });
        } else {
          setState(() {
            print('end message 333');

            nextIndex++;

            count = 0;
          });
        }
      }
    }
  }

  nextButtonMethod(WirdProvider wirdData) {
    count = 0;

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
     percentage = nextIndex / wirdData.getWirdList.length * 1;
      return Scaffold(
          // appBar: AppBar(
          //   title: const Text('Wirdul-Latif '),
          //   actions: [
          //     InkWell(
          //       onDoubleTap: (() {
          //         setState(() {
          //           nextIndex = 0;
          //         });
          //       }),
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Column(
          //           children: [
          //             Text(percentage > 100
          //                 ? '100.0%'
          //                 : '${percentage.roundToDouble().toString()}%'),
          //             Text('Reset')
          //           ],
          //         ),
          //       ),
          //     )
          //   ],
          //   centerTitle: true,
          // ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton.extended(
                      backgroundColor: WirdColors.primaryColor,
                      onPressed: () {
                        print(percentage);

                        prevButtonMethod(wirdData);
                      },
                      label: const Text(
                        '  Prev  ',
                        style: TextStyle(color: Color.fromARGB(255, 254, 213, 100),fontWeight: FontWeight.bold,),
                      )),
                  FloatingActionButton.large(
                      backgroundColor: WirdColors.primaryColor,
                      onPressed: () {
                        countButtonMethod(wirdData);
                      },
                      child: Text(
                          endMessage
                              ? 'finished'
                              : '$count /${wirdData.getWirdList[nextIndex].count.toString()}',
                          style: TextStyle(color: WirdColors.seconderyColor))),
                  FloatingActionButton.extended(
                      backgroundColor: WirdColors.primaryColor,
                      onPressed: () {
                        print(percentage);
                        nextButtonMethod(wirdData);
                      },
                      label: const Text('  Next  ',
                          style: TextStyle(color: WirdColors.seconderyColor))),
                ],
              ),
            ),
          ),
          body: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity! > 0) {
                // User swiped Left
                prevButtonMethod(wirdData);
              } else if (details.primaryVelocity! < 0) {
                // User swiped Right
                nextButtonMethod(wirdData);
              }
            },
            onTap: () {
              countButtonMethod(wirdData);
            },
            child: Column(
              children: [
                Container(
                  // color: Colors.blue,
                  child: Image.asset(
                    'asset/masjid_arc.png',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        arabicTextWidget(context, wirdData),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.orange,
                      child: Column(
                        children: [
                          Expanded(child: SizedBox()),
                          SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: percentage,
                              backgroundColor: WirdColors.seconderyColor.withOpacity(0.5),
                              valueColor: AlwaysStoppedAnimation(
                                  WirdColors.primaryColor),
                            ),
                          )
                        ],
                      ),
                    ))
                // Expanded(child: SizedBox())
              ],
            ),
          ));
    });
  }

  Directionality arabicTextWidget(BuildContext context, WirdProvider wirdData) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Colors.transparent,
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
                    style: GoogleFonts.amiri(fontWeight: FontWeight.bold,
                      fontSize: 28,
                      )
                    
                  ),
          ),
        ),
      ),
    );
  }
}
