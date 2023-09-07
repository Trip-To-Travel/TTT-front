import 'package:app/model/diary_model.dart';
import 'package:app/screens/calendar/calendar.dart';
import 'package:app/screens/diary/viewDiary.dart';
import 'package:app/screens/diary/writeDiary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DiaryModel? _selectedDiary = null;


  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();


  @override
  void initState() {
    final today = DateTime.now();
    super.initState();
    _getDiary(today).then((value) => {
      _selectedDiary = _getDiaryForSelectedDate(_selectedDay)
  });
  }

  List<DiaryModel> _diaryList = [];

  Future<void> _getDiary(DateTime targetDate, {bool isRefresh = false}) async {
    if (isRefresh) {
      _diaryList.clear();
    }
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("diary")
        .orderBy("date", descending: true)
        .where('date', isGreaterThanOrEqualTo: new DateTime(targetDate.year, targetDate.month, 1))
        .where('date', isLessThanOrEqualTo: new DateTime(targetDate.year, targetDate.month+1, 0))
        .get();
    setState(() {
      _diaryList = snapshot.docs
          .map((e) => DiaryModel.fromFirestore(e.data()))
          .toList();
    });
  }


  List<String> _getEventsForDay(DateTime day) {
    final parseDate = _diaryList.where((item) => DateFormat('yy-MM-dd').format(item.date.toDate()) == DateFormat('yy-MM-dd').format(day));
    if (parseDate.isNotEmpty) {
      return ["true"];
    } else {
      return [];
    }
  }

  DiaryModel? _getDiaryForSelectedDate(DateTime selectedDate) {
    final List<DiaryModel> matchDiaryList = _diaryList.where((item) => DateFormat('yy-MM-dd').format(item.date.toDate()) == DateFormat('yy-MM-dd').format(selectedDate)).toList();
    if(matchDiaryList.isEmpty){
      return null;
    } else {
      return matchDiaryList.first;
    }
  }

  Future<List<dynamic>> _getDiaryForTerm(DateTime startDate, DateTime endDate) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("diary")
        .orderBy("date", descending: true)
        .where('date', isGreaterThanOrEqualTo: new DateTime(startDate.year, startDate.month, startDate.day))
        .where('date', isLessThanOrEqualTo: new DateTime(endDate.year, endDate.month, endDate.day))
        .get();

    return [snapshot.docs
        .map((e) => DiaryModel.fromFirestore(e.data()))
        .toList(), snapshot.docs.length];
  }

  // 날짜 필터
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
                      _getDiary(focusedDay, isRefresh: true);
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
                          onPressed: () async {
                            if(_startDate!= null && _endDate!= null){
                              await _getDiaryForTerm(_startDate!, _endDate!).then((data) => {
                                  setState(() {
                                    _startDate = null;
                                    _endDate = null;
                                  }),
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Calendar(
                                  diaryList: data[0],
                                  diaryNum: data[1],
                                )))
                              });
                            }
                          },
                          child: const Text("적용")
                      )
                    ],
                  ),

                  // 선택할때 다이어리 미리 보기 뜨는 곳.
                  if (_selectedDiary != null)
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDiary(selectedDate: _selectedDiary!.date.toDate())));},
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
                                  child: _selectedDiary!.image_list.isNotEmpty ? Image.network(
                                    _selectedDiary!.image_list.first != null ? _selectedDiary!.image_list.first as String : "",
                                    fit: BoxFit.fill,
                                    width: idealWidth * 120,
                                    height: idealHeight * 120,
                                  ) : null,
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
                                      Text(_selectedDiary!.date != null ? DateFormat('yy/MM/dd').format( _selectedDiary!.date.toDate()) as String : "",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(_selectedDiary!.title != null ? _selectedDiary!.title as String : "default",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
                                        ),
                                      ),
                                      Text(_selectedDiary!.content != null ? _selectedDiary!.content as String : "",
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => WriteDiary(selectedDate: _selectedDay,)));
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
