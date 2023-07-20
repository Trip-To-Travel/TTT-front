import 'package:app/screens/diary/viewDiary.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
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
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("2023", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                      Text("07.02 ~ 07.08", style: TextStyle(fontSize: 18,),)
                    ],
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
                              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDiary()));},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                      height: double.infinity,
                                      child: Image(
                                        image: AssetImage(itemList[index]["image"]),
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  ),
                                  SizedBox(
                                    width: idealWidth * 160,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(itemList[index]["date"]),
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
