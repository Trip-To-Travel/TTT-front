import 'package:app/model/diary_model.dart';
import 'package:app/screens/diary/writeDiary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewDiary extends StatefulWidget {
  final DateTime selectedDate;
  const ViewDiary({super.key, required this.selectedDate});

  @override
  State<ViewDiary> createState() => _ViewDiaryState();
}

class _ViewDiaryState extends State<ViewDiary> {
  DiaryModel? _diary = null;
  DateTime _targetDate = DateTime.now();
  final koreanDateFormat = DateFormat('E', 'ko_KR');

  Future<void> _getDiary(DateTime targetDate) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("diary")
        .orderBy("date", descending: true)
        .where('date', isGreaterThanOrEqualTo: new DateTime(targetDate.year, targetDate.month, targetDate.day))
        .where('date', isLessThan: new DateTime(targetDate.year, targetDate.month, targetDate.day + 1))
        .get();
    setState(() {
      if(snapshot.docs.isNotEmpty) {
        _diary = snapshot.docs.map((e) => DiaryModel.fromFirestore(e.data())).first;
      }
    });
  }


  @override
  void initState() {
    super.initState();
    _targetDate = widget.selectedDate;
    _getDiary(_targetDate);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final idealWidth = deviceWidth / 375;
    final idealHeight = deviceHeight / 667;

    return Scaffold(
      appBar: _diary != null ? AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        title: Text(
          "${DateFormat("yyyy년 MM월 dd일").format(_diary!.date.toDate())} (${koreanDateFormat.format(_diary!.date.toDate())})",
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
      ) : null,
      body: _diary != null ? SafeArea(
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
                              _diary!.title.toString(),
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
                          child: Text(_diary!.content.toString()),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(7, 3, 7, 11),
              sliver: SliverToBoxAdapter(
                child: _diary!.image_list.isNotEmpty ? SizedBox(
                  width: double.infinity,
                  height: deviceWidth - 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _diary?.image_list.toList().length,
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
                            child: Image.network(
                              _diary!.image_list[index],
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // 이미지 로딩이 완료된 경우 이미지를 표시
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator( // 로딩 중에는 로딩 인디케이터를 표시
                                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!: null,
                                    ),);
                                  }
                            })
                        ),
                      );
                    },
                  ),
                ) : null,
              ),
            )
          ]
        ),
      ) : null,
    );
  }
}
