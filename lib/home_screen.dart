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
  int index = 0;
  bool endMessage = false;
  var count = 0;
  double percentage = 0;
  late bool checkIfWirdCounterIsOne;

  String quote =
      'People are in need of the Prophetic du’ā’s now, more than ever, because there are shayateen everywhere. If we could see the unseen world, I’m telling you, we would all pass out. Because there are demons all over the place. What you’re doing whilst reciting invocations and litanies is creating a space around you, that if the Jinn and shaytaan see it, they have to back away. If you are consistent with this (Wird al Latif), I guarantee you will see a difference in your life. And if you miss it out you’ll feel horrible during the day – it’ll feel like going outside without brushing your teeth. Put yourself in the protection of Allāh through daily du’ā"';

  prevButtonMethod(WirdProvider wirdData) {
    endMessage = false;
    count = 0;
    print(index);
    if (index != 0) {
      setState(() {
        index--;
      });
    }
  }

  countButtonMethod(WirdProvider wirdData) {
    if (endMessage) {
      print('end message');
      return null;
    } else {
      if (count < wirdData.getWirdList[index].count - 1) {
        print('end message 1111');

        setState(() {
          count++;
        });
      } else {
        if (index == wirdData.getWirdList.length - 1) {
          setState(() {
            endMessage = true;
          });
        } else {
          setState(() {
            print('end message 333');

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
      endMessage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WirdProvider>(
        builder: (BuildContext context, wirdData, Widget? child) {
      percentage = index / wirdData.getWirdList.length * 1;
      var CounterPercentage = count / wirdData.getWirdList[index].count * 1;
      var individualWirdCounter = Positioned(
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
                      valueColor:
                          AlwaysStoppedAnimation(WirdColors.primaryColor),
                      backgroundColor: WirdColors.seconderyColor,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            // color: Colors.blue,

                            shape: BoxShape.circle),
                        // color: Colors.blue,

                        child: Center(
                            child: checkWirdCounterIsOne(wirdData)
                                ? Text(
                                    '${wirdData.getWirdList[index].count.toString()}')
                                : Text('')))
                  ],
                ),
              ))));
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
                  Stack(
                    children: [
                      Container(
                        // color: Colors.blue,
                        child: Image.asset(
                          'asset/masjid_arc.png',
                        ),
                      ),
                      individualWirdCounter,
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
                      child: GestureDetector(
                        onTap: () {
                          countButtonMethod(wirdData);
                        },
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
                                      value: endMessage ? 1 : percentage,
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
                        ),
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
        )),
      );
    });
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
            child: endMessage
                ? Column(
                    children: [
                      Text(quote,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poorStory(
                              fontSize: 14, color: WirdColors.primaryColor)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Shaykh Hamza Yusuf',
                        style: 
                        GoogleFonts.teko(
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
}
