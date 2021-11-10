import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: unused_import

// ignore: unused_element
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// ignore: unused_element
final Future<FirebaseApp> _initialization = Firebase.initializeApp();

FirebaseAuth auth = FirebaseAuth.instance;
User? user = FirebaseAuth.instance.currentUser;
// ignore: unused_element
var _enteredMessage = '';
final _controller = new TextEditingController();
String? uid;



class Navigalist extends StatelessWidget {


  void _sendMessage() async {
    // FocusScope.of(context).unfocus();
    _controller.clear();
    // ignore: unused_local_variable
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    // FirebaseFirestore.instance.collection('chat').add({
    //   // 'text': _enteredMessage,
    //   // 'createdAt': Timestamp.now(),
    //   'userId': user!.uid,
    //   'userName': userData['${'Name'}'],
    //   'numberHN': userData['numberHN'],
    //   'userImage': userData['image_url'],
    // });
    _enteredMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final userData =
        FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    _sendMessage();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Text(
                  'User',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900),
                )),
            accountName: Text(
              'ชื่อ : นายสมมุติ ทดสอบ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700),
            ),
            accountEmail: Text(
              // ignore: unnecessary_brace_in_string_interps
              '',
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title:
                const Text('ข้อมูลผู้ใช้งาน', style: TextStyle(fontSize: 20.0)),
            subtitle: Text('ข้อมูลของผู้ใช้'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title:
                const Text('ข้อมูลยาในระบบ', style: TextStyle(fontSize: 20.0)),
            subtitle: Text('ข้อมูลยาโรคความดันโลหิตสูง'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('ตั้งค่า', style: TextStyle(fontSize: 20.0)),
            subtitle: Text('ตั้งค่าการใช้งาน'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: const Text('ออกจากระบบ', style: TextStyle(fontSize: 20.0)),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              print(uid);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
