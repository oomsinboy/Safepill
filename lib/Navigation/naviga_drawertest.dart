import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:flutter_application_1/login/loginMail/loginmail_screen.dart';

class DrawerTest extends StatefulWidget {
  const DrawerTest({Key? key}) : super(key: key);

  @override
  _DrawerTestState createState() => _DrawerTestState();
}

class _DrawerTestState extends State<DrawerTest> {
  // ignore: unused_field
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // ignore: unused_field
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  // ignore: unused_field
  var _enteredMessage = '';
  final _controller = new TextEditingController();
  late String uid;
  // ignore: non_constant_identifier_names
  late String Name;
  late String numberHN;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    findUid();
  }

  void signOut(BuildContext context) {
    auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        ModalRoute.withName('/'));
  }

//หาค่า Uid ของ User ที่ login อยู่
  Future<Null> findUid() async {
    await Firebase.initializeApp().then((value) async {
      // ignore: await_only_futures
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          uid = event!.uid;
          Name = event.displayName!;
          numberHN = event.phoneNumber!;
        });
      });
    });
  }

//   Future<Null> findName() async {
//     await Firebase.initializeApp().then((value) async {
//       await FirebaseAuth.instance.authStateChanges().listen((event) {
//         setState(() {
//           name = event!.displayName;
//         });
//       });
//     });
//   }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final userData =
        FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    //_sendMessage();
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
            accountName: 
            Text(
              // ignore: unnecessary_brace_in_string_interps
              'ชื่อ : ${Name}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700),
            ),
            accountEmail: Text(
              // ignore: unnecessary_brace_in_string_interps
              'หมายเลข HN : ${numberHN}',
              style: TextStyle(color: Colors.black, fontSize: 10.0),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title:
                const Text('ข้อมูลผู้ใช้งาน', style: TextStyle(fontSize: 20.0)),
            subtitle: Text('ข้อมูลของผู้ใช้'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.pushNamed(context, '/page datauser'),
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title:
                const Text('ข้อมูลยาในระบบ', style: TextStyle(fontSize: 20.0)),
            subtitle: Text('ข้อมูลยาโรคความดันโลหิตสูง'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () => Navigator.pushNamed(context, '/medpill'),
          ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: const Text('ตั้งค่า', style: TextStyle(fontSize: 20.0)),
          //   subtitle: Text('ตั้งค่าการใช้งาน'),
          //   trailing: Icon(Icons.keyboard_arrow_right),
          //   onTap: () => Navigator.pop(context),
          // ),
          Divider(),
          ListTile(
            title: const Text('ออกจากระบบ', style: TextStyle(fontSize: 20.0)),
            trailing: Icon(Icons.exit_to_app),
            onLongPress: () {
              signOut(context);
            },

            // onTap: () async {
            //   await Firebase.initializeApp().then((value) async {
            //     await FirebaseAuth.instance.signOut().then((value) =>
            //         Navigator.pushNamedAndRemoveUntil(
            //             context, '/authen', (route) => false));
            //   });
            // },
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
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
}
