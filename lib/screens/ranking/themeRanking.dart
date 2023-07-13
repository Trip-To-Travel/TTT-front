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
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black,
              child: Container(
                width: double.infinity,
                height: idealHeight * 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
                  )
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: idealHeight * 260,
                    child: Text(
                      "반가워용"
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
