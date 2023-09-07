import 'package:app/model/diary_model.dart';
import 'package:app/screens/diary/viewDiary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  final List<DiaryModel> diaryList;
  final int diaryNum;

  const Calendar({super.key, required this.diaryList, required this.diaryNum});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final koreanDateFormat = DateFormat('E', 'ko_KR');
  List<DiaryModel>? _diaryList;
  int? _diaryNum;

  @override
  void initState() {
    super.initState();
    _diaryList = widget.diaryList;
    _diaryNum = widget.diaryNum;
  }


  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final idealWidth = deviceWidth / 375;
    final idealHeight = deviceHeight / 667;


    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("일별 달력", style: TextStyle(color: Colors.black, fontSize: 16),),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.calendar_month))
          ],
        ),
        body: SafeArea(
          child: Container(
            height: deviceHeight,
            width: deviceWidth,
            padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 32, 0, 20),
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${DateFormat("yyyy/MM/dd").format(_diaryList!.first.date.toDate())} (${koreanDateFormat.format(_diaryList!.first.date.toDate())})"!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(
                          width: 6,
                        ),
                        Text("~", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 6,
                        ),
                        Text("${DateFormat("yyyy/MM/dd").format(_diaryList!.last.date.toDate())} (${koreanDateFormat.format(_diaryList!.last.date.toDate())})"!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 18.0,
                          childAspectRatio: 1 / 0.5,
                        ),
                        itemCount: _diaryNum,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDiary(selectedDate: DateTime.now())));},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _diaryList![index].image_list.isNotEmpty ? Expanded(
                                    child:  Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                      height: double.infinity,
                                      child: Container(
                                        padding: EdgeInsets.all(0.5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(_diaryList![index].image_list.first),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      )
                                    ),
                                  ) : SizedBox(),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  SizedBox(
                                    width: _diaryList![index].image_list.isNotEmpty ? idealWidth * 160 : idealWidth * 320,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${DateFormat("yyyy년 MM월 dd일").format(_diaryList![index].date.toDate())} (${koreanDateFormat.format(_diaryList![index].date.toDate())})",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Text(_diaryList![index].content),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                    )
                )
              ],
            ),
          )
        )
    );
  }
}
