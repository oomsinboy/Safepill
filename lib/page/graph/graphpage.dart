import 'package:flutter/material.dart';
import 'package:flutter_application_1/function/graphps.dart';

class PageGraphtest extends StatefulWidget {
  const PageGraphtest({Key? key}) : super(key: key);

  @override
  _PageGraphtestState createState() => _PageGraphtestState();
}

class _PageGraphtestState extends State<PageGraphtest> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
//  drawer: Navigalist(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF3a73b5),

          title: Text("ความดันโลหิตของฉัน"),
          //title: AppBarTitle(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FlLineChartExample(),
        ),
      ),
    );
  }
}
