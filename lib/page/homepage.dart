import 'package:flutter/material.dart';
import 'package:flutter_application_1/Navigation/naviga_drawertest.dart';
// import 'package:flutter_application_1/Navigation/naviga_drawer.dart';

import 'package:flutter_application_1/function/ui/adddrug.dart';
import 'package:table_calendar/table_calendar.dart';
// ignore: unused_import
import 'package:speed_dial_fab/speed_dial_fab.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerTest(),
      appBar: AppBar(
        backgroundColor: Color(0xFF3a73b5),
        title: Text('หน้าหลัก'),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          TableCalendar(
            //locale: 'pl_PL',

            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            //style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                //borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.circle,
                //borderRadius: BorderRadius.circular(5.0),
              ),
              weekendTextStyle: TextStyle(color: Colors.red),
            ),

            //style Week
            daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(
                  color: Colors.red,
                ),
                weekdayStyle: TextStyle(color: Colors.black)),

            //headerStyle
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
              formatButtonDecoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20.0),
              ),
              formatButtonTextStyle: TextStyle(color: Colors.white),
              leftChevronIcon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 15,
              ),
              rightChevronIcon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 15,
              ),
            ),
          ),

          /*Expanded(
            child: Container()
            ),*/

          /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Adddrug()));
                },
                child: Container(
                  margin: EdgeInsets.all(50),
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    color: Colors.blue,                    
                  ),
                  child: Text("เพิ่มยาที่นี้", style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                   ),
                  ),
                ),
              ),
            ],
          ),*/

          Container(
            height: 60,
            margin: EdgeInsets.all(100),
            width: double.infinity,
            // ignore: deprecated_member_use
            child: FlatButton(
              child: Text(
                "เพิ่มยาที่นี่",
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Adddrug()));
              },
              color: Colors.blueAccent,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),

      // floatingActionButton: SpeedDialFabWidget(
      //   secondaryIconsList: [
      //     Icons.medication_rounded,
      //     Icons.favorite,
      //   ],
      //   secondaryIconsText: [
      //     "เพิ่มยาของฉัน",
      //     "เพิ่มความดันโลหิตของฉัน",
      //   ],
      //   secondaryIconsOnPress: [
      //     () => {},
      //     () => {},
      //   ],
      //   secondaryBackgroundColor: Colors.white,
      //   secondaryForegroundColor: Colors.black,
      //   primaryBackgroundColor: Colors.blueAccent,
      //   primaryForegroundColor: Colors.black,
      //   primaryIconExpand: Icons.add,
      //   primaryIconCollapse: Icons.close,
      // ),
      //backgroundColor: Color(0xFF73AEF5)
    );
  }
}
