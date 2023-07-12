import 'package:app/screens/calendar/calendar.dart';
import 'package:app/screens/diary/writeDiary.dart';
import 'package:flutter/material.dart';

class CalendarMain extends StatefulWidget {
  const CalendarMain({super.key});

  @override
  State<CalendarMain> createState() => _CalendarMainState();
}

class _CalendarMainState extends State<CalendarMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Calendar()))
            },
            child: new Text('No'),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => WriteDiary()));
        },
        backgroundColor: Color(0xff76BDFF),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0))
        ),
        child: const Icon(Icons.mode_edit_outline_outlined, color: Colors.white,),
      ),

    );
  }
}
