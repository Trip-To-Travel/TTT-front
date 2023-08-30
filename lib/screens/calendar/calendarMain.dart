import 'package:app/screens/calendar/calendar.dart';
import 'package:app/screens/diary/viewDiary.dart';
import 'package:app/screens/diary/writeDiary.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMain extends StatefulWidget {
  const CalendarMain({super.key});

  @override
  State<CalendarMain> createState() => _CalendarMainState();
}

class _CalendarMainState extends State<CalendarMain> {
  DateTime? _startDate;
  DateTime? _endDate;

  bool _showTodayButton = false;


  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Map<String, String> _selectedDiary = {};

  @override
  void initState() {
    super.initState();
    _selectedDiary = _getDiaryForSelectedDate(_selectedDay);
  }

  List<Map> itemList = [
    {
      "image" : "assets/images/mockimg1.jpg",
      "date" : "2023-07-01",
      "title" : "내가 어쩌고 저쩌고",
      "detail" : "내가 어쩌고 저쩌고",
    },
    {
      "image" : "assets/images/mockimg2.jpg",
      "date" : "2023-07-18",
      "title" : "내가 어쩌고 저쩌고",
      "detail" : "내가 어쩌고 저쩌고",
    },
    {
      "image" : "assets/images/mockimg3.jpg",
      "date" : "2023-07-20",
      "title" : "내가 어쩌고 저쩌고",
      "detail" : "내가 어쩌고 저쩌고",
    },
  ];

  List<String> _getEventsForDay(DateTime day) {
    final parseDate = itemList.where((item) => item["date"] == day.toString().split(" ")[0]);
    if (parseDate.isNotEmpty) {
      return ["true"];
    } else {
      return [];
    }
  }

  String _getWeekDay(DateTime selectedDate) {
    String weekday = ['월', '화', '수', '목', '금', '토', '일'][DateTime.now().weekday - 1];
    return weekday;
  }

  Map<String, String> _getDiaryForSelectedDate(DateTime selectedDate) {
    final formattedDate = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
    final matchingItems = itemList.where((item) => item['date'] == formattedDate).toList();
    if (matchingItems.isNotEmpty) {
      return {
        "image" : matchingItems[0]['image'],
        "date" : matchingItems[0]['date'],
        "title" : matchingItems[0]['title'],
        "detail" : matchingItems[0]['detail']
      };
    } else {
      return {};
    }
  }

  Future<void> _showStartDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2023, 12, 31),
    );

    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _showEndDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2023, 12, 31),
    );

    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final idealWidth = deviceWidth / 375;
    final idealHeight = deviceHeight / 667;

    return Scaffold(
      body: SafeArea(
        child: Stack(
            children: [
              Column(
                children: [
                  TableCalendar(
                    locale: 'ko_KR',
                    firstDay: DateTime.utc(2000, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    // locale: 'ko-KR',
                    focusedDay: _focusedDay,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    calendarStyle: const CalendarStyle(
                      cellMargin : EdgeInsets.all(12.0),
                      todayDecoration : BoxDecoration(
                        color: Colors.black38,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.black, // 선택된 날짜의 색상을 변경합니다.
                        shape: BoxShape.circle, // 선택된 날짜의 형태를 사각형으로 변경합니다.
                      ),
                      markerSize: 4.5,
                      markersAnchor : 0,
                      markerDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle
                      ),
                    ),
                    eventLoader: _getEventsForDay,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _selectedDiary = _getDiaryForSelectedDate(selectedDay);
                        if (_selectedDay.toString().split(" ")[0] == DateTime.now().toString().split(" ")[0]) {
                          _showTodayButton = false;
                        } else {
                          _showTodayButton = true;
                        }
                      });
                    },
                    onPageChanged: (focusedDay) {
                      setState(() {
                        if(focusedDay.month == DateTime.now().month) {
                          _selectedDay = DateTime.now();
                          _focusedDay = DateTime.now();
                        } else {
                          _selectedDay = focusedDay;
                          _focusedDay = focusedDay;
                        }

                        _selectedDiary = _getDiaryForSelectedDate(_selectedDay);
                        if (_focusedDay.toString().split(" ")[0] == DateTime.now().toString().split(" ")[0]) {
                          _showTodayButton = false;
                        } else if (_showTodayButton == false) {
                          _showTodayButton = true;
                        }
                      });
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _showStartDatePicker,
                        child: Text(_startDate==null? "시작 날짜" :_startDate.toString().split(" ")[0]),
                      ),
                      const Text("~"),
                      ElevatedButton(
                        onPressed: _showEndDatePicker,
                        child: Text(_endDate==null? "끝 날짜" :_endDate.toString().split(" ")[0]),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if(_startDate!= null && _endDate!= null){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Calendar(
                                startDate: _startDate.toString().split(" ")[0],
                                endDate: _endDate.toString().split(" ")[0],
                              )));
                            }
                          },
                          child: const Text("적용")
                      )
                    ],
                  ),

                  // 선택할때 다이어리 미리 보기 뜨는 곳.
                  if (_selectedDiary.isNotEmpty)
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewDiary()));},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(9, 5, 9, 0),
                        child: Container(
                          height: idealHeight * 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    _selectedDiary["image"]!= null ? _selectedDiary["image"] as String : "",
                                    fit: BoxFit.fill,
                                    width: idealWidth * 120,
                                    height: idealHeight * 120,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(_selectedDiary["date"]!= null ? _selectedDiary["date"] as String : "",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(_selectedDiary["title"]!= null ? _selectedDiary["title"] as String : "default",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
                                        ),
                                      ),
                                      Text(_selectedDiary["detail"]!= null ? _selectedDiary["detail"] as String : "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              // 오늘로 돌아오는 버튼
              if (_showTodayButton && _selectedDay != DateTime.now())
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(const Size(85, 30)),
                      ),
                      onPressed: () {
                        setState(() {
                          _showTodayButton = false;
                          _selectedDay = DateTime.now();
                          _focusedDay = DateTime.now();
                          _selectedDiary = _getDiaryForSelectedDate(DateTime.now());
                        });
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.chevron_left),
                          Text('오늘')
                        ],
                      ),
                    ),
                  ),
                ),
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => WriteDiary(selectedDate: "${_selectedDay.toString().split(" ")[0]} (${_getWeekDay(_selectedDay)})",)));
        },
        backgroundColor: const Color(0xff76BDFF),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0))
        ),
        child: const Icon(Icons.mode_edit_outline_outlined, color: Colors.white,),
      ),
    );
  }
}
