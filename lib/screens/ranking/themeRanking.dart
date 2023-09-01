import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeRanking extends StatefulWidget {
  const ThemeRanking({
    required this.themeCode,
    required this.image,
    required this.theme,
  });

  final String themeCode;
  final String image;
  final String theme;

  @override
  State<ThemeRanking> createState() => _ThemeRankingState();
}

class _ThemeRankingState extends State<ThemeRanking> {

  dynamic itemList = [ // todo: 추후 query(select~ sort~ limit=20~) 실행 결과가 여기에 담기도록 하면 되겠죠
    {
      "category_group_code": "0",
      "image" : "assets/images/mockimg1.jpg",
      "place_name": "스너글",
      "address_name": "개신동 263-15",
      "road_address_name": "충북 청주시 서원구 성봉로 242번길 51",
      "number_of_visitors": 134,
    },
    {
      "category_group_code": "1",
      "image" : "assets/images/mockimg2.jpg",
      "place_name": "이달의 커피",
      "address_name": "개신동 496-16",
      "road_address_name": "충북 청주시 서원구 성봉로 242번길 28",
      "number_of_visitors": 90,
    },
    {
      "category_group_code": "2",
      "image" : "assets/images/mockimg3.jpg",
      "place_name": "아르떼커피 충대정문점",
      "address_name": "복대동 872-15",
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
                          "트래블러가 많이 찾은 \"${widget.theme}\" 테마 여행지 스무 곳을 소개합니다.",
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
          SliverPadding( // todo: 여기 InkWell 씌워서, 클릭 시 해당 장소에 대한 정보 나타내도록 하는 건 어떨까?
            padding: EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10.0,
                childAspectRatio: 5 / 3, //item 의 가로 3, 세로 2 의 비율
              ),
              // 화면에 표시될 위젯을 설정
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Column(
                    children: [
                      Flexible(
                        flex: 4,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                                width: double.infinity,
                                height: double.infinity,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    "${index+1}".padLeft(2, '0'),
                                    style: const TextStyle(
                                      color: Colors.black12,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 8,
                              child: Column(
                                children: [
                                  const Spacer(flex: 1,),
                                  Flexible(
                                    flex: 3,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          flex: 3,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(itemList[index]["image"]),
                                                    fit: BoxFit.cover
                                                )
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 4,
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Text( // 장소 명
                                                    itemList[index]["place_name"],
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                        child: const Icon(
                                                          Icons.pin_drop_sharp, size: 16,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text( // 주소
                                                          itemList[index]["road_address_name"],
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                        padding: const EdgeInsets.all(1),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1,
                                                          )
                                                        ),
                                                        child: const Text(
                                                          "지번",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey,
                                                          ),
                                                        )
                                                      ),
                                                      Flexible(
                                                        child: Text( // 지번
                                                          itemList[index]["address_name"],
                                                          textAlign: TextAlign.justify,
                                                          style: const TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: const Icon(
                                  Icons.remove_red_eye_sharp, size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "${itemList[index]["number_of_visitors"]}",
                                style: const TextStyle(
                                  color: Color(0xff76BDFF),
                                ),
                              ),
                              const Text(
                                "명이 이 장소에 방문했어요."
                              )
                            ],
                          ),
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
