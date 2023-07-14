import 'dart:ui';

import 'package:flutter/material.dart';

class themeRanking extends StatefulWidget {
  const themeRanking({
    required this.themeCode,
    required this.image,
    required this.theme,
  });

  final int themeCode;
  final String image;
  final String theme;

  @override
  State<themeRanking> createState() => _themeRankingState();
}

class _themeRankingState extends State<themeRanking> {

  dynamic itemList = [ // todo: 추후 query(select~ sort~ limit=20~) 실행 결과가 여기에 담기도록 하면 되겠죠
    {
      "category_group_code": "0",
      "image" : "assets/images/mockimg1.jpg",
      "place_name": "스너글",
      "road_address_name": "충북 청주시 서원구 성봉로242번길 51",
      "number_of_visitors": 134,
    },
    {
      "category_group_code": "1",
      "image" : "assets/images/mockimg2.jpg",
      "place_name": "이달의 커피",
      "road_address_name": "충북 청주시 서원구 성봉로242번길 28",
      "number_of_visitors": 90,
    },
    {
      "category_group_code": "2",
      "image" : "assets/images/mockimg3.jpg",
      "place_name": "아르떼커피 충북대정문점",
      "road_address_name": "충북 청주시 흥덕구 충대로 2",
      "number_of_visitors": 78,
    },
  ];

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
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("테마 랭킹", style: TextStyle(color: Colors.black, fontSize: 16),),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter( // 타이틀
            child: Container(
              color: Colors.black,
              child: Container(
                width: double.infinity,
                height: idealHeight * 240,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
                  )
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(flex: 2,),
                        Text(
                          widget.theme,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "TOP 20",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(flex: 1,),
                        Text(
                          "트래블러가 많이 찾은 \"${widget.theme}\" 스무 곳을 소개합니다.",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10.0,
                childAspectRatio: 2 / 1, //item 의 가로 1, 세로 1 의 비율
              ),
              // 화면에 표시될 위젯을 설정
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "${index+1}".padLeft(2, '0'),
                            ),
                          ),
                          Container(
                            width: idealWidth * 80,
                            height: idealWidth * 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(itemList[index]["image"]),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text( // 장소 명
                                  itemList[index]["place_name"],
                                ),
                                Text( // 주소
                                  itemList[index]["road_address_name"],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: Text(
                          "${itemList[index]["number_of_visitors"]} 명이 이 장소에 방문했어요."
                        ),
                      )
                    ],
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
