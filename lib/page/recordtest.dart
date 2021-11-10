// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/page/student.dart';
// import 'package:form_field_validator/form_field_validator.dart';

// class FormScreen extends StatefulWidget {
//   @override
//   _FormScreenState createState() => _FormScreenState();
// }

// class _FormScreenState extends State<FormScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("บันทึก"),
//       ),
//       body: Form(
//         child: Column(
//           children: [
//             TextFormField(
//               decoration: new InputDecoration(labelText: "เทส แถว 1"),
//             ),
//             TextFormField()
//           ],
//         ),
//       ),
//     );
//   }
// }


// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_application_1/Navigation/naviga_drawer.dart';

// // class Record extends StatefulWidget {
// //   @override
// //   _RecordState createState() => _RecordState();
// // }

// // class _RecordState extends State<Record> {
// //   late DateTime pickedDate;
// //   late TimeOfDay time;

// //   void initState() {
// //     super.initState();
// //     pickedDate = DateTime.now();
// //     time = TimeOfDay.now();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final recordButton = Material(
// //       elevation: 5,
// //       borderRadius: BorderRadius.circular(30),
// //       color: Colors.blueAccent,
// //       child: MaterialButton(
// //           padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
// //           minWidth: MediaQuery.of(context).size.width,
// //           onPressed: () {
// //             //Navigator.push(context, MaterialPageRoute(builder: (context) => Adddrug()));
// //           },
// //           child: Text(
// //             "บันทึก",
// //             textAlign: TextAlign.center,
// //             style: TextStyle(
// //               fontSize: 24,
// //               color: Colors.white,
// //             ),
// //           )),
// //     );

// //     return Scaffold(
// //       drawer: Navigalist(),
// //       appBar: AppBar(
// //         backgroundColor: Color(0xFF3a73b5),
// //         title: Text('บันทึกค่าความดันโลหิต'),
// //       ),
// //       body: ListView(
// //         children: <Widget>[
// //           Padding(
// //             padding: const EdgeInsets.all(28),
// //             child: Center(
// //               child: Column(
// //                 children: [
// //                   ListTile(
// //                     title: Text(
// //                       "วันที่ : ${pickedDate.day}/${pickedDate.month}/${pickedDate.year} ",
// //                       style: TextStyle(
// //                         fontSize: 20,
// //                       ),
// //                     ),
// //                     trailing: Icon(Icons.arrow_drop_down),
// //                     onTap: _pickDate,
// //                   ),

// //                   /*TextFormField(                    
// //                     keyboardType: TextInputType.datetime,
// //                     decoration: InputDecoration(
// //                         //prefixIcon: Icon(Icons.vpn_key), 
// //                       //icon: Icon(Icons.date_range),                
// //                       labelText: 'วันที่',
// //                       labelStyle: TextStyle(fontSize: 18
// //                         ),
// //                       border: OutlineInputBorder(),
// //                       filled: true,
// //                       //onClicked () => 
// //                       //fillColor: Colors.white54
// //                      ) 
// //                   ),*/

// //                   /*SizedBox(
// //                     height: 12,
// //                    ),*/

// //                   ListTile(
// //                     title: Text(
// //                       "เวลา : ${time.hour} : ${time.minute}",
// //                       style: TextStyle(
// //                         fontSize: 20,
// //                       ),
// //                     ),
// //                     trailing: Icon(Icons.arrow_drop_down),
// //                     onTap: _pickTime,
// //                   ),

// //                   /*TextFormField(                    
// //                     keyboardType: TextInputType.datetime,
// //                     decoration: InputDecoration(
// //                         //prefixIcon: Icon(Icons.vpn_key),                        
// //                       prefixIcon: Icon(Icons.timer),          
// //                       labelText: 'เวลา',
// //                       labelStyle: TextStyle(fontSize: 18
// //                         ),
// //                       border: OutlineInputBorder(),
// //                       filled: true,
// //                       //fillColor: Colors.white54
// //                      ) 
// //                   ),*/
// //                   SizedBox(
// //                     height: 12,
// //                   ),
// //                   TextFormField(
// //                       autofocus: false,
// //                       keyboardType: TextInputType.numberWithOptions(),
// //                       decoration: InputDecoration(
// //                         //prefixIcon: Icon(Icons.vpn_key),
// //                         labelText: 'ความดันโลหิตด้านบน',
// //                         labelStyle: TextStyle(fontSize: 18),
// //                         border: OutlineInputBorder(),
// //                         filled: true,
// //                         //fillColor: Colors.white54
// //                       )),
// //                   SizedBox(height: 12),
// //                   TextFormField(
// //                       autofocus: false,
// //                       //keyboardType: TextInputType.numberWithOptions(),
// //                       decoration: InputDecoration(
// //                         //prefixIcon: Icon(Icons.vpn_key),
// //                         labelText: 'ความดันโลหิตด้านล่าง',
// //                         labelStyle: TextStyle(fontSize: 18),
// //                         border: OutlineInputBorder(),
// //                         filled: true,
// //                         //fillColor: Colors.white54
// //                       )),
// //                   SizedBox(
// //                     height: 12,
// //                   ),
// //                   TextFormField(
// //                       autofocus: false,
// //                       keyboardType: TextInputType.numberWithOptions(),
// //                       decoration: InputDecoration(
// //                         //prefixIcon: Icon(Icons.vpn_key),
// //                         labelText: 'อัตราเต้นของหัวใจ',
// //                         labelStyle: TextStyle(fontSize: 18),
// //                         border: OutlineInputBorder(),
// //                         filled: true,
// //                         //fillColor: Colors.white54
// //                       )),
// //                   Padding(
// //                       padding: const EdgeInsets.only(top: 0.0),
// //                       child: Center(
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             TextButton(
// //                               onPressed: () => Navigator.pushNamed(
// //                                   context, '/detail pressure'),
// //                               child: Text(
// //                                 'ความดันระดับไหนถึงผิดปกติ ?',
// //                                 style: TextStyle(
// //                                     fontSize: 16.0, color: Colors.black),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       )),
// //                   SizedBox(height: 12),
// //                   recordButton,
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       //backgroundColor: Color(0xFF73AEF5)
// //     );
// //   }

        

// //   _pickDate() async {
// //     DateTime? date = await showDatePicker(
// //       context: context,
// //       firstDate: DateTime(DateTime.now().year - 5),
// //       lastDate: DateTime(DateTime.now().year + 5),
// //       initialDate: pickedDate,
// //     );

// //     if (date != null)
// //       setState(() {
// //         pickedDate = date;
// //       });
// //   }

// //   _pickTime() async {
// //     // ignore: unused_local_variable
// //     final initialTime = TimeOfDay(hour: 9, minute: 0);
// //     final newTime = await showTimePicker(context: context, initialTime: time);

// //     if (newTime == null) return;
// //     setState(() {
// //       time = newTime;
// //     });
// //   }
// // }



// /*


// test record 


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Navigation/naviga_drawer.dart';
// import 'package:flutter_application_1/function/addtemp.dart';
// import 'package:flutter_application_1/home.dart';

// class Record extends StatefulWidget {
//   @override
//   _RecordState createState() => _RecordState();
// }


// class _RecordState extends State<Record> {
//   @override
//   Widget build(BuildContext context) {


    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("บันทึก"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                   decoration: new InputDecoration(labelText: "เทส แถว 1"),
//                   autofocus: true, //circer kraprip when you click page!!!
//                   keyboardType: TextInputType.number),
//               TextFormField(
//                 decoration: new InputDecoration(labelText: "เทส แถว 2"),
//                 keyboardType: TextInputType.number,
//               ),
//               Material(
//                 elevation: 5,
//                 borderRadius: BorderRadius.circular(30),
//                 color: Colors.blueAccent,
//                 child: MaterialButton(
//                     padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
//                     minWidth: MediaQuery.of(context).size.width,
//                     onPressed: () {
//                       // Navigator.pushNamed(context, '/addtemp'),

//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => AddTemp()),
//                       );
//                     },
//                     child: Text(
//                       "บันทึก",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 24,
//                         color: Colors.white,
//                       ),
//                     )),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// */