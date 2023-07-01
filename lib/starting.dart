import 'package:app/home.dart';
import 'package:flutter/material.dart';


class Starting extends StatefulWidget {
  final String title;

  const Starting({
    super.key,
    required this.title,
  });

  @override
  State<Starting> createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  bool _state = true;
  final int primaryColor = 0xff76BDFF;

  @override
  void initState() {
    _getThingsOnStartup(500).then((value) {
      setState(() {
        _state = false;
      });
      _getThingsOnStartup(2000).then((value) => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()))
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(primaryColor),
          gradient: LinearGradient(
            colors: [Color(primaryColor), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        alignment: Alignment.center,
        child: AnimatedOpacity(
          opacity: _state ? 0.0 : 1.0,
          duration: Duration(milliseconds: 1500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/img.png')),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 28,
                    shadows: [
                      Shadow( // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: Colors.blue
                      ),
                      Shadow( // bottomRight
                          offset: Offset(1.5, -1.5),
                          color: Colors.blue
                      ),
                      Shadow( // topRight
                          offset: Offset(1.5, 1.5),
                          color: Colors.blue
                      ),
                      Shadow( // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: Colors.blue
                      ),
                    ]
                ),
              ),
            ],
          ),
        )
    );


  }

  Future _getThingsOnStartup (int milliseconds) async {
    await Future.delayed (Duration (milliseconds : milliseconds));
  }

}
