import 'package:app/screens/diary/viewDiary.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  final String startDate;
  final String endDate;

  const Calendar({super.key, required this.startDate, required this.endDate});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  String? _startDate;
  String? _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.startDate;
    _endDate = widget.endDate;
  }


  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final idealWidth = deviceWidth / 375;
    final idealHeight = deviceHeight / 667;

    dynamic itemList = [
      {
        "image" : "assets/images/mockimg1.jpg",
        "date" : "2023.07.01 (화)",
        "detail" : "내가 어쩌고 저쩌고",
      },
      {
        "image" : "assets/images/mockimg2.jpg",
        "date" : "2023.07.01 (화)",
        "detail" : "내가 어쩌고 저쩌고",
      },
      {
        "image" : "assets/images/mockimg3.jpg",
        "date" : "2023.07.01 (화)",
        "detail" : "내가 어쩌고 저쩌고",
      },
    ];


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
                        Text(_startDate!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(
                          width: 6,
                        ),
                        Text("~", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 6,
                        ),
                        Text(_endDate!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
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
                        itemCount: itemList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDiary(selectedDate: DateTime.now())));},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                      height: double.infinity,
                                      child: Container(
                                        padding: EdgeInsets.all(0.5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: AssetImage(itemList[index]["image"]),
                                                fit: BoxFit.cover)
                                        ),
                                      )
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  SizedBox(
                                    width: idealWidth * 160,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(itemList[index]["date"], style: TextStyle(fontWeight: FontWeight.bold),),
                                        Text(itemList[index]["detail"]),
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
