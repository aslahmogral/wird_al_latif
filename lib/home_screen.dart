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
      var CounterPercentage = count / wirdData.getWirdList[nextIndex].count * 1;
      // var percentageBy100 = nextIndex / wirdData.getWirdList.length * 100;
      return Scaffold(
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.only(left: 20),
          //   child: SizedBox(
          //     height: 120,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         FloatingActionButton.large(
          //             backgroundColor: WirdColors.primaryColor,
          //             onPressed: () {
          //               countButtonMethod(wirdData);
          //             },
          //             child: Text(endMessage ? 'finished' : '$count',
          //                 // : '$count /${wirdData.getWirdList[nextIndex].count.toString()}',
          //                 style: TextStyle(
          //                     color: WirdColors.seconderyColor,
          //                     fontWeight: FontWeight.bold))),
          //       ],
          //     ),
          //   ),
          // ),
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
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      // color: Colors.blue,
                      child: Image.asset(
                        'asset/masjid_arc.png',
                      ),
                    ),
                    Positioned(
                        bottom: 30,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CircularProgressIndicator(
                                    value: CounterPercentage,
                                    valueColor: AlwaysStoppedAnimation(
                                        WirdColors.primaryColor),
                                    backgroundColor: WirdColors.seconderyColor,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          // color: Colors.blue,

                                          shape: BoxShape.circle),
                                      // color: Colors.blue,

                                      child: Center(
                                          child: Text(
                                              '${wirdData.getWirdList[nextIndex].count.toString()}')))
                                ],
                              ),
                            )))),
                  ],
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
                        Row(
                          children: [
                            SizedBox(
                              width: 40,
                            ),
                            Expanded(
                                child: arabicTextWidget(context, wirdData)),
                            SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          // color: Colors.green,
                          decoration: BoxDecoration(
                              color: WirdColors.seconderyColorDark,
                              border: Border.all(
                                  color: WirdColors.primaryColor, width: 5),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(100),
                                  topRight: Radius.circular(100))),
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.orange,
                          child: Column(
                            children: [
                              Expanded(child: SizedBox()),
                              SizedBox(
                                height: 10,
                                child: LinearProgressIndicator(
                                  value: percentage,
                                  backgroundColor: WirdColors.seconderyColor
                                      .withOpacity(0.5),
                                  valueColor: AlwaysStoppedAnimation(
                                      WirdColors.primaryColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset('asset/finger_print.png'),
                          ),
                        )
                      ],
                    ))
                // Expanded(child: SizedBox())
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                // color: Colors.green,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => prevButtonMethod(wirdData),
                      child: Container(
                        child: Icon(
                          Icons.arrow_left,
                          size: 40,
                          color: WirdColors.seconderyColor,
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () => nextButtonMethod(wirdData),
                      child: Container(
                        child: Icon(
                          Icons.arrow_right,
                          size: 50,
                          color: WirdColors.seconderyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                : Text(wirdData.getWirdList[nextIndex].arabic,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.amiri(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    )),
          ),
        ),
      ),
    );
  }
}
