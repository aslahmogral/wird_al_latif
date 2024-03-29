import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wird_al_latif/components/curve.dart';
import 'package:wird_al_latif/model/wird_model.dart';
import 'package:wird_al_latif/provider/wird_provider.dart';
import 'package:wird_al_latif/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController(initialPage: 0);
  List<WirdModel>? wirdList = [];
  int count = 0;
  int _currentPage = 0;
  int wirdListLength = 44;

  @override
  void initState() {
    super.initState();
    setState(() {
      getWirdData();
    });
    _currentPage = 0;
    controller.addListener(() {
      setState(() {
        _currentPage = controller.page!.toInt();
      });
    });
  }

  getWirdData() async {
    final _wirdProvider =
        await Provider.of<WirdProvider>(context, listen: false);
    await _wirdProvider.loadLocalJsonData();
    wirdList = await _wirdProvider.wirddata;
    wirdListLength = _wirdProvider.wirddata!.length;
    print(_wirdProvider.wirddata);
  }

  List<Widget> bodyWidget(List<WirdModel>? wirdlist) {
    List<Widget> finalList = [];

    wirdlist?.forEach((element) {
      finalList.add(Stack(
        children: [
          Column(
            children: [
              AppbarArea(context),
              SizedBox(
                height: 20,
              ),
              TextShowArea(context, element)
            ],
          ),
          sideNavigateButtons()
        ],
      ));
    });

    return finalList;
  }

  Stack AppbarArea(BuildContext context) {
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

  Expanded TextShowArea(BuildContext context, WirdModel element) {
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
                Expanded(child: arabicTextWidget(context, element)),
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

  Container arabicTextWidget(BuildContext context, WirdModel element) {
    return Container(
      color: Colors.transparent,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text("${element.arabic} ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.amiri(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    )),
              ),
              SizedBox(height: 30,),
              Text('(${element.rep} times)',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }

  Column sideNavigateButtons() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 2, child: SizedBox()),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              InkWell(
                onTap: () => {
                  controller.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear)
                },
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
                onTap: () {
                  print(controller.page);
                  controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
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
        Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WirdProvider>(
          builder: (BuildContext context, wirdData, Widget? child) {
        return PageView(
          controller: controller,
          children: [...bodyWidget(wirdList)],
        );
      }),
      bottomNavigationBar: BottomCounterButton(context),
    );
  }

  Widget BottomCounterButton(
    BuildContext context,
  ) {
    return Container(
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
                onTap: () async {
                  // countButtonMethod(wirdData);
                  var rep = await wirdList![controller.page!.toInt()].rep;
                  print(wirdList![controller.page!.toInt()].rep);
                  setState(() {
                    count++;
                    print(count);
                  });
                  if (rep == count || rep < count) {
                    count = 0;
                    controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear);
                  }
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
                                      color: Colors.white.withOpacity(0.4),
                                      colorBlendMode: BlendMode.modulate,
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '$count',
                                        // count.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ]),
                              ),
                            )),
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
              children: [Text("${_currentPage + 1}/44")],
            ),
          )
        ],
      ),
    );
  }
}
