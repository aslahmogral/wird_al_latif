import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wird_al_latif/components/curve.dart';
import 'package:wird_al_latif/provider/wird_provider.dart';
import 'package:wird_al_latif/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  bool endOfApp = false;
  var count = 0;
  double percentage = 0;
  late bool checkIfWirdCounterIsOne;

  String quote =
      'People are in need of the Prophetic du’ā’s now, more than ever, because there are shayateen everywhere. If we could see the unseen world, I’m telling you, we would all pass out. Because there are demons all over the place. What you’re doing whilst reciting invocations and litanies is creating a space around you, that if the Jinn and shaytaan see it, they have to back away. If you are consistent with this (Wird al Latif), I guarantee you will see a difference in your life. And if you miss it out you’ll feel horrible during the day – it’ll feel like going outside without brushing your teeth. Put yourself in the protection of Allāh through daily du’ā"';

  prevButtonMethod(WirdProvider wirdData) {
    if (endOfApp == true) {
      setState(() {
        endOfApp = false;
      });
      print('endof : made to false');
    } else if (index != 0) {
      print('endof :not equal to zero');

      setState(() {
        index--;
      });
    }
    count = 0;
    print(index);
  }

  countButtonMethod(WirdProvider wirdData) {
    if (endOfApp) {
      print('end message');
      return null;
    } else {
      if (count < wirdData.getWirdList[index].count - 1) {
        setState(() {
          count++;
        });
      } else {
        if (index == wirdData.getWirdList.length - 1) {
          setState(() {
            endOfApp = true;
          });
        } else {
          setState(() {
            index++;

            count = 0;
          });
        }
      }
    }
  }

  nextButtonMethod(WirdProvider wirdData) {
    count = 0;
    if (index <= wirdData.getWirdList.length - 2) {
      index++;
      setState(() {
        print('nextbutton : $index');
      });
    } else {
      setState(() {});
      endOfApp = true;
    }
  }

  Align sideNavigateButtons(WirdProvider wirdData) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // color: Colors.green,
        child: Row(
          children: [
            index == 0
                ? SizedBox()
                : InkWell(
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
            endOfApp
                ? SizedBox()
                : InkWell(
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
    );
  }

  Stack AppbarArea(BuildContext context, WirdProvider wirdData) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          // color: Colors.blue,
          child: Image.asset(
            'asset/masjid_arc.png',
          ),
        ),
        Positioned(
            bottom: 0,
            child: SizedBox(
                // width: MediaQuery.of(context).size.width / 2.3,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Image.asset('asset/bismillah.png')),
                      ],
                    )))),
      ],
    );
  }

  Expanded TextShowArea(BuildContext context, WirdProvider wirdData) {
    return Expanded(
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
                Expanded(child: arabicTextWidget(context, wirdData)),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BottomCounterButton(
    WirdProvider wirdData,
    BuildContext context,
  ) {
    return endOfApp
        ? Container(
            width: MediaQuery.of(context).size.width,
            child: SizedBox(
              height: 100,
              width: 100,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(WirdColors.primaryColor)),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text(
                      'EXIT',
                      style: TextStyle(
                          color: WirdColors.seconderyColor,
                          fontSize: 20,
                          letterSpacing: 4,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          )
        : Container(
            height: 180,
            child: Stack(
              // clipBehavior: Clip.none,
              children: [
                RotatedBox(
                    quarterTurns: 2,
                    child: ClipPath(
                      clipper: CurveClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          //linear-gradient(90deg, rgba(56,94,142,1) 0%, rgba(25,56,94,1) 3%, rgba(31,10,77,1) 7%);
                          Color.fromARGB(56, 94, 142, 1),
                          Color.fromARGB(25, 56, 94, 1),
                          Color.fromARGB(31, 10, 77, 1),
                        ])),
                        height: 180,
                      ),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 150,
                    child: GestureDetector(
                      onTap: () {
                        countButtonMethod(wirdData);
                      },
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: ClipPath(
                          clipper: CurveClipper(),
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 239, 211, 133),
                                      Color.fromARGB(255, 236, 205, 117),
                                      Color(0xffF3C137),
                                      Color(0xffF3C137),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),

                                // ),
                              ),
                              // width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Container(
                                    height: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 30.0,
                                      ),
                                      child: Stack(children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            'asset/white_fingerprint.png',
                                            color:
                                                Colors.white.withOpacity(0.4),
                                            colorBlendMode: BlendMode.modulate,
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              count.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 50,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ]),
                                    ),
                                  )),
                                  SizedBox(
                                    height: 10,
                                    child: LinearProgressIndicator(
                                      value: endOfApp ? 1 : percentage,
                                      backgroundColor: WirdColors.seconderyColor
                                          .withOpacity(0.5),
                                      valueColor: AlwaysStoppedAnimation(
                                          WirdColors.primaryColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Goal - ${wirdData.getWirdList[index].count.toString()}',style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                )
              ],
            ),
          );
  }

  bool checkWirdCounterIsOne(WirdProvider wirdData) {
    if (wirdData.getWirdList[index].count == 1) {
      return false;
    } else {
      return true;
    }
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
            child: endOfApp
                ? Column(
                    children: [
                      Text(quote,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poorStory(
                              fontSize: 20, color: WirdColors.primaryColor)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Shaykh Hamza Yusuf',
                          style: GoogleFonts.teko(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: WirdColors.seconderyColorDark))
                    ],
                  )
                : Text(wirdData.getWirdList[index].arabic,
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

  @override
  Widget build(BuildContext context) {
    return Consumer<WirdProvider>(
        builder: (BuildContext context, wirdData, Widget? child) {
      percentage = index / wirdData.getWirdList.length * 1;
      // var CounterPercentage = count;
      // var individualWirdCounter = ;
      return SafeArea(
        child: Scaffold(
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
            child: Stack(
              children: [
                Column(
                  children: [
                    AppbarArea(context, wirdData),
                    SizedBox(
                      height: 20,
                    ),

                    TextShowArea(context, wirdData),
                    // BottomCounterButton(wirdData, context)
                    // Expanded(child: SizedBox())
                  ],
                ),
                sideNavigateButtons(wirdData),
                // RotatedBox(
                //   quarterTurns: 2,
                //   child: ClipPath(
                //     clipper: CurveClipper(),
                //     child: Container(
                //       color: Colors.red,
                //       height: 200.0,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          bottomNavigationBar: BottomCounterButton(
            wirdData,
            context,
          ),
        ),
      );
    });
  }
}
