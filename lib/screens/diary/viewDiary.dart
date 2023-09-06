import 'package:app/screens/diary/writeDiary.dart';
import 'package:flutter/material.dart';

class ViewDiary extends StatefulWidget {
  const ViewDiary({super.key});

  @override
  State<ViewDiary> createState() => _ViewDiaryState();
}

class _ViewDiaryState extends State<ViewDiary> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final idealWidth = deviceWidth / 375;
    final idealHeight = deviceHeight / 667;

    dynamic itemList = [
      {
        "image" : "assets/images/mockimg1.jpg",
      },
      {
        "image" : "assets/images/mockimg2.jpg",
      },
      {
        "image" : "assets/images/mockimg3.jpg",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        title: Text(
          "2023년 7월 14일 (금)",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => WriteDiary(selectedDate: DateTime.now(),)));
          }, icon: Icon(Icons.edit_outlined))
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(11, 0, 11, 3),
              sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              "제목입니다.",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                              "1. 삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로"
                                  " 1.삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로 "
                                  "1. 삶이 있는 한 희망은 있다 -키케로"
                                  "1. 삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로"
                                  " 1.삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로 "
                                  "1. 삶이 있는 한 희망은 있다 -키케로"
                                  "1. 삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로"
                                  "1. 삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로"
                                  " 1.삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로 "
                                  "1. 삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로 1. 삶이 있는 한 희망은 있다 -키케로"
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(7, 3, 7, 11),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  width: double.infinity,
                  height: deviceWidth - 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                        width: deviceWidth - 50,
                        height: deviceWidth - 50,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            child: Image(
                              image: AssetImage(itemList[index]["image"]),
                              fit: BoxFit.fill,
                            )
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}
