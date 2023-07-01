import 'package:app/screens/calendar/calendar.dart';
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
    );
  }
}
