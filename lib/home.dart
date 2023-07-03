import 'package:app/screens/calendar/calendarMain.dart';
import 'package:app/screens/map.dart';
import 'package:app/screens/mypage/mypageMain.dart';
import 'package:app/screens/ranking.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    CalendarMain(),
    Map(),
    Ranking(),
    MyPage()
  ];

  late List<GlobalKey<NavigatorState>> _navigatorKeyList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatorKeyList = List.generate(_pages.length, (index) => GlobalKey<NavigatorState>());
  }

  final PageStorageBucket bucket = PageStorageBucket();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            body: IndexedStack(
              index: _currentIndex,
              children: _pages.map((page) {
                int index = _pages.indexOf(page);
                return Navigator(
                  key: _navigatorKeyList[index],
                  onGenerateRoute: (_) {
                    return MaterialPageRoute(builder: (context) => page);
                  },
                );
              }).toList(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Color(0xff76BDFF),
              unselectedItemColor: Colors.grey,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.calendar_month,
                  ),
                  label: '달력',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.map_outlined,
                  ),
                  label: '지도',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bar_chart,
                  ),
                  label: '랭킹',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.person
                    ),
                    label: '마이페이지'
                ),
              ],
            ),
        ),
      onWillPop: () async {
        return !(await _navigatorKeyList[_currentIndex].currentState!.maybePop());
      },
    );
  }
}
