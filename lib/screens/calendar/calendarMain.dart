import 'package:app/screens/diary/writeDiary.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMain extends StatefulWidget {
  const CalendarMain({super.key});

  @override
  State<CalendarMain> createState() => _CalendarMainState();
}

class _CalendarMainState extends State<CalendarMain> {
  Map<DateTime, String> photoMap = {};

  List<String> _selectedImages = [];
  bool _showTodayButton = false;


  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  String _selectedImage = "";

  @override
  void initState() {
    super.initState();
    _selectedImages = _getImagesForSelectedDate(_selectedDay);
  }


  dynamic itemList = [
    {
      "image" : "assets/images/mockimg1.jpg",
      "date" : "2023-07-01",
      "detail" : "내가 어쩌고 저쩌고",
    },
    {
      "image" : "assets/images/mockimg2.jpg",
      "date" : "2023-07-18",
      "detail" : "내가 어쩌고 저쩌고",
    },
    {
      "image" : "assets/images/mockimg3.jpg",
      "date" : "2023-07-20",
      "detail" : "내가 어쩌고 저쩌고",
    },
  ];

  String _getWeekDay(DateTime selectedDate) {
    String weekday = ['월', '화', '수', '목', '금', '토', '일'][DateTime.now().weekday - 1];
    return weekday;
  }

  String _getImageForSelectedDate(DateTime selectedDate) {
    final formattedDate = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}"; // yyyy.MM.dd 형식으로 변경
    final matchingItems = itemList.where((item) => item['date'] == formattedDate).toList();
    print(formattedDate);
    print(itemList[0]["date"]);
    if (matchingItems.isNotEmpty) {
      return matchingItems[0]['image'];
    } else {
      return "";
    }
  }

  List<String> _getImagesForSelectedDate(DateTime selectedDate) {
    final formattedDate = selectedDate.toString().split(" ")[0]; // yyyy-MM-dd 형식으로 변경
    final matchingItems = itemList.where((item) => item['date'] == formattedDate).toList();
    if (matchingItems.isNotEmpty) {
      return matchingItems.map<String>((item) => item['image'] as String).toList();
    } else {
      return [];
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
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _selectedImage = _getImageForSelectedDate(selectedDay);
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

                      _selectedImage = _getImageForSelectedDate(_selectedDay);
                      if (_focusedDay.toString().split(" ")[0] == DateTime.now().toString().split(" ")[0]) {
                        _showTodayButton = false;
                      } else if (_showTodayButton == false) {
                        _showTodayButton = true;
                      }
                    });
                  },
                ),
                SizedBox(height: 20),
                if (_selectedImage.isNotEmpty)
                  Image.asset(
                    _selectedImage,
                    width: 200,
                    height: 200,
                  ),

              ],
            ),

            if (_showTodayButton && _selectedDay != DateTime.now())
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(Size(85, 30)), // 버튼의 크기를 조정
                    ),
                    onPressed: () {
                      setState(() {
                        _showTodayButton = false;
                        _selectedDay = DateTime.now();
                        _focusedDay = DateTime.now();
                        _selectedImages = _getImagesForSelectedDate(DateTime.now());
                        _selectedImage = _getImageForSelectedDate(DateTime.now()); // 오늘 날짜에 맞는 사진 할당
                      });
                    },
                    child: Row(
                      children: [
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
        backgroundColor: Color(0xff76BDFF),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0))
        ),
        child: const Icon(Icons.mode_edit_outline_outlined, color: Colors.white,),
      ),
    );
  }
}
