import 'dart:ui';

import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {

  dynamic itemList = [
    {
      "image" : "assets/images/mockimg1.jpg",
      "theme" : "전체",
    },
    {
      "image" : "assets/images/mockimg2.jpg",
      "theme" : "카페",
    },
    {
      "image" : "assets/images/mockimg3.jpg",
      "theme" : "익스트림",
    },
    {
      "image" : "assets/images/mockimg3.jpg",
      "theme" : "쏼라쏼라",
    },
    {
      "image" : "assets/images/mockimg2.jpg",
      "theme" : "저쩌구",
    },
    {
      "image" : "assets/images/mockimg1.jpg",
      "theme" : "어쩌그",
    },
  ];

  final _cities = ['서울', '대전', '대구', '부산', '인천', '울산', '광주'];
  String? _selectedCity;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedCity = _cities[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final idealWidth = deviceWidth / 375;
    final idealHeight = deviceHeight / 667;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: idealHeight * 260,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff040E57), Color(0xff3549AF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),


              child: Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 4,),
                    Text(
                      "랭킹 📈",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    Spacer(flex: 1,),
                    Text(
                      "여행을 떠날 준비가 되셨나요?\n현대 도시의 화려한 경관부터 자연 속의 평화로움까지,\n여러분에게 꼭 맞는 테마를 찾아보세요.\n특별한 추억과 환상적인 경험을 선사할 것입니다.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(flex: 1,),

                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(8, 9, 8, 9),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Spacer(),
                  SizedBox(
                    width: idealWidth*50,
                    child: DropdownButton(
                      style: TextStyle(color: Colors.black),
                      value: _selectedCity,
                      items: _cities.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCity = value!;
                        });
                      },
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: idealWidth*50,
                    child: DropdownButton(
                      style: TextStyle(color: Colors.black),
                      value: _selectedCity,
                      items: _cities.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCity = value!;
                        });
                      },
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: idealWidth*50,
                    child: DropdownButton(
                      style: TextStyle(color: Colors.black),
                      value: _selectedCity,
                      items: _cities.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCity = value!;
                        });
                      },
                    ),
                  ),
                  Spacer(flex: 2,),
                  IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                  Spacer(),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
              ),
              // 화면에 표시될 위젯을 설정
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(0.5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(itemList[index]["image"]),
                            fit: BoxFit.cover)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                itemList[index]['theme'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: itemList.length,
              ),
            ),

          )
        ],
      ),
    );
  }
}
