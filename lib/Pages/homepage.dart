import 'package:clock_poco/Classes/tab_button.dart';
import 'package:clock_poco/Pages/AlarmPage/alarm_page.dart';
import 'package:clock_poco/Pages/ClockPage/clock_page.dart';
import 'package:clock_poco/Pages/CounterPage/counter_page.dart';
import 'package:clock_poco/Pages/TimerPage/timer_page.dart';
import 'package:clock_poco/Pages/settings.dart';
import 'package:clock_poco/main.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications_platform_interface/flutter_local_notifications_platform_interface.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({Key? key, this.notificationAppLaunchDetails})
      : super(key: key);

  final NotificationAppLaunchDetails? notificationAppLaunchDetails;

  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;
  int _selectedPage = 0;
  bool isPageSelected = false;
  PageController _pageController = PageController(
    keepPage: true,
  );

  void _changePage(int pageNum) {
    setState(() {
      _selectedPage = pageNum;
      _pageController.animateToPage(
        pageNum,
        duration: Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    // _configureSelectNotificationSubject();
    super.initState();
  }

  ///for full screen notification navigator
  // void _configureSelectNotificationSubject() {
  //   selectNotificationSubject.stream.listen((String? payload) async {
  //     await Navigator.pushNamed(context, '/showalarmpage');
  //   });
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TabButton(
                        icon: _selectedPage == 0
                            ? Icons.alarm_sharp
                            : Icons.alarm,
                        iconsize: 25,
                        pageNumber: 0,
                        selectedPage: _selectedPage,
                        onPressed: () {
                          _changePage(0);
                        },
                      ),
                      TabButton(
                        icon: _selectedPage == 0
                            ? Icons.schedule_sharp
                            : Icons.schedule,
                        iconsize: 25,
                        pageNumber: 1,
                        selectedPage: _selectedPage,
                        onPressed: () {
                          _changePage(1);
                        },
                      ),
                      TabButton(
                        icon: _selectedPage == 0
                            ? Icons.timer_sharp
                            : Icons.timer,
                        iconsize: 25,
                        pageNumber: 2,
                        selectedPage: _selectedPage,
                        onPressed: () {
                          _changePage(2);
                        },
                      ),
                      TabButton(
                        icon: _selectedPage == 0
                            ? Icons.hourglass_empty_sharp
                            : Icons.hourglass_empty_outlined,
                        iconsize: 25,
                        pageNumber: 3,
                        selectedPage: _selectedPage,
                        onPressed: () {
                          _changePage(3);
                        },
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    child: PopupMenuButton(
                      onSelected: (index) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Settings()));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      color: Colors.grey[800],
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(
                            "Settings",
                            style: TextStyle(color: Colors.white),
                          ),
                          value: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: PageView(
                onPageChanged: (int page) {
                  setState(() {
                    _selectedPage = page;
                  });
                },
                controller: _pageController,
                children: [
                  AlarmPage(),
                  ClockPage(),
                  TimerPage(),
                  CounterPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
