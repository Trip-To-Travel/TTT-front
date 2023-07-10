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
      body: Column(
        children: [
          Text(widget.themeCode.toString()),
          Container(
            padding: EdgeInsets.all(0.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(widget.image),
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
                        widget.theme,
                        style: const TextStyle(
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
          ),
        ],
      ),
    );
  }
}
