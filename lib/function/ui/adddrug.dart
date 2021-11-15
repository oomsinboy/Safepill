import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Navigation/naviga_drawertest.dart';
import 'package:flutter_application_1/controller/task_controller.dart';
import 'package:flutter_application_1/function/ui/add_task_bar.dart';
import 'package:flutter_application_1/function/button.dart';
import 'package:flutter_application_1/function/ui/notification_services.dart';
import 'package:flutter_application_1/controller/task_tile.dart';
import 'package:flutter_application_1/function/ui/theme.dart';
import 'package:flutter_application_1/function/ui/themeService.dart';
import 'package:flutter_application_1/controller/task.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Adddrug extends StatefulWidget {
  const Adddrug({Key? key}) : super(key: key);

  @override
  _AdddrugState createState() => _AdddrugState();
}

class _AdddrugState extends State<Adddrug> {
  // ignore: unused_field
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    //notifyHelper.requestPermissions();
    setState(() {
      print("หน้าหลัก");
    });
  }

  @override
  Widget build(BuildContext context) {
    print('buil method called');
    return Scaffold(
      drawer: DrawerTest(),
      appBar: _appBar(
          /*backgroundColor: Color(0xFF3a73b5),
          title: Text('เพิ่มยา'),*/
          ),
      //backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(
            height: 10,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    print('show DATA');
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            Task task = _taskController.taskList[index];
            print(_taskController.taskList.length);
            if (task.repeat == 'Daily') {
              DateTime date = DateFormat.jm().parse(task.startTime.toString());
              var myTime = DateFormat('HH:mm').format(date);
              notifyHelper.scheduledNotification(
                int.parse(myTime.toString().split(':')[0]),
                int.parse(myTime.toString().split(':')[1]),
                task,
              );
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ),
                    ),
                  ));

            }
            if(task.date==DateFormat.yMd().format(_selectedDate)){
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ),
                    ),
                  ));
            }else{
              return Container();
            }
          });
    }));
  }

  /*_showTasks() {
    print('show DATA');
    return Expanded(
      child: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return _noTaskMsg();
        } else
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _taskController.taskList.length,
              itemBuilder: (context, index) {
                Task task = _taskController.taskList[index];
                if (task.repeat == 'Daily') {

                  var hour= task.startTime.toString().split(":")[0];
                  var minutes = task.startTime.toString().split(":")[1];
                  debugPrint("My time is "+hour);
                  debugPrint("My minute is "+minutes);
                  DateTime date= DateFormat.jm().parse(task.startTime!);
                  var myTime = DateFormat("HH:mm").format(date);
  /*
                  print("my date "+date.toString());
                  print("my time " +myTime);
                  var t=DateFormat("M/d/yyyy hh:mm a").parse(task.date+" "+task.startTime);
                  print(t);
                  print(int.parse(myTime.toString().split(":")[0]));*/
                  notifyHelper.scheduledNotification(int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]), task);

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                      horizontalOffset: 300.0,
                      child: FadeInAnimation(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  //showBottomSheet(context, task);
                                },
                                child: TaskTile(task)),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (task.date == DateFormat.yMd().format(_selectedDate)) {
                  notifyHelper.scheduledNotification();
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                      horizontalOffset: 300.0,
                      child: FadeInAnimation(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {

                                  //showBottomSheet(context, task);
                                },
                                child: TaskTile(task)),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              });
      }),
    );
  }*/

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(top: 2),
          height: task.isCompleted == 1
              ? MediaQuery.of(context).size.height * 0.24
              : MediaQuery.of(context).size.height * 0.32,
          color: Get.isDarkMode ? darkGreyClr : Colors.white,
          child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
              ),
              Spacer(),
              task.isCompleted == 1
                  ? Container()
                  : _bottomSheetButton(
                      label: "สำเร็จแล้ว",
                      onTap: () {
                        _taskController.markTaskCompleted(task.id!);
                        Get.back();
                      },
                      clr: primaryClr,
                      context: context),
              _bottomSheetButton(
                  label: "ลบข้อมูล",
                  onTap: () {
                    _taskController.delete(task);

                    Get.back();
                  },
                  clr: Colors.red[300]!,
                  context: context),
              SizedBox(
                height: 20,
              ),
              _bottomSheetButton(
                  label: "ออก",
                  onTap: () {
                    Get.back();
                  },
                  clr: Colors.red[300]!,
                  isClose: true,
                  context: context),
              SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: DatePicker(
        DateTime.now(),
        height: 90,
        width: 70,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
          
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  " วันนี้",
                  style: HeadingStyle,
                )
              ],
            ),
          ),
          MyButton(
              label: "+ เพิ่มยา",
              onTap: () async {
                await Get.to(() => AddTaskPage());
                _taskController.getTasks();
              })
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      //backgroundColor: context.theme.backgroundColor,
      /*leading: GestureDetector(
        onTap:(){
          Get.back();
        },
        child: 
              Icon(Get.isDarkMode ? Icons.arrow_back_ios : Icons.arrow_back_ios,
              size: 20, color: Get.isDarkMode ? Colors.white : Colors.black),
            
      ),*/

      actions: [
        GestureDetector(
          onTap: () {
          //Get.back();
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Dark Theme"
                  : "Activated Light Theme");

          notifyHelper.scheduledNotification;
        },
        child: Icon(
            Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
       
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 2000),
          //left: left,
          //top:top,
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*SvgPicture.asset(
                "images/task.svg",
                color: primaryClr.withOpacity(0.5),
                height: 90,
                semanticsLabel: 'Task',
              ),*/
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  "              คุณยังไม่มียาแจ้งเตือน!\n          Add new tasks to make your days productive.",
                  textAlign: TextAlign.center,
                  style: subtitleStyle,
                ),
              ),
              SizedBox(
                height: 80,
              ),
            ],
          )),
        )
      ],
    );
  }

}