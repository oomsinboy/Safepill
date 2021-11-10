import 'package:flutter/material.dart';
import 'package:flutter_application_1/test/res/custom_colors.dart';
import 'package:flutter_application_1/test/utils/database.dart';
import 'package:flutter_application_1/test/utils/validator.dart';
import 'package:intl/intl.dart';

import 'custom_form_field.dart';

class AddItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  final FocusNode heartrate;

  const AddItemForm(
      {required this.titleFocusNode,
      required this.descriptionFocusNode,
      required this.heartrate});

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  late DateTime pickedDate;
  late TimeOfDay time;
  late String dateUTC;

  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  bool _isProcessing = false;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _heartrate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _addItemFormKey,
        child: SingleChildScrollView(
            child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.0),
                    ListTile(
                      title: Text(
                        "วันที่ : ${pickedDate.day} - ${pickedDate.month} - ${pickedDate.year} ",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_drop_down),
                      onTap: _pickDate,
                    ),
                    ListTile(
                      title: Text(
                        "เวลา : ${time.hour} : ${time.minute}",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_drop_down),
                      onTap: _pickTime,
                    ),
                    Divider(),
                    Text(
                      'ความดันโลหิตด้านบน (SYS)',
                      style: TextStyle(
                        color: CustomColors.firebaseGrey,
                        fontSize: 22.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8.0),

                    CustomFormField(
                      isLabelEnabled: false,
                      controller: _titleController,
                      focusNode: widget.titleFocusNode,
                      keyboardType: TextInputType.number,
                      inputAction: TextInputAction.next,
                      validator: (value) => Validator.validateField(
                        value: value,
                      ),
                      label: 'Title',
                      hint: 'mmHg',
                    ),

                    ////////////////////////////////////
                    SizedBox(height: 24.0),

                    Text(
                      'ความดันโลหิตด้านล่าง (DIA)',
                      style: TextStyle(
                        color: CustomColors.firebaseGrey,
                        fontSize: 22.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CustomFormField(
                      isLabelEnabled: false,
                      controller: _descriptionController,
                      focusNode: widget.descriptionFocusNode,
                      keyboardType: TextInputType.number,
                      inputAction: TextInputAction.next,
                      validator: (value) => Validator.validateField(
                        value: value,
                      ),
                      label: 'Description',
                      hint: 'mmHg',
                    ),
                    /////////////////////////////////////
                    SizedBox(height: 24.0),
                    Text(
                      'อัตราการเต้นของหัวใจ (PUL)',
                      style: TextStyle(
                        color: CustomColors.firebaseGrey,
                        fontSize: 22.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CustomFormField(
                      isLabelEnabled: false,
                      controller: _heartrate,
                      focusNode: widget.heartrate,
                      keyboardType: TextInputType.number,
                      inputAction: TextInputAction.done,
                      validator: (value) => Validator.validateField(
                        value: value,
                      ),
                      label: 'Description',
                      hint: '/ นาที',
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, '/detail pressure'),
                                child: Text(
                                  'ความดันระดับไหนถึงผิดปกติ ?',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              if (_isProcessing)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.firebaseOrange,
                    ),
                  ),
                )
              else
                Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      widget.titleFocusNode.unfocus();
                      widget.descriptionFocusNode.unfocus();
                      widget.heartrate.unfocus();

                      if (_addItemFormKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await Database.addItem(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          heartrate: _heartrate.text,
                          data_time: _dateController.text,
                        );
                        setState(() {
                          _isProcessing = false;
                        });

                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        'บันทึก',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        )));
  }

  // ignore: unused_element
  _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );

    if (date != null)
      setState(() {
        pickedDate = date;
        String formattedDate = DateFormat('dd-MMMM-yyyy').format(pickedDate);
        _dateController.text = formattedDate;
        dateUTC = DateFormat('yyyy-MMMM-dd').format(pickedDate);
      });
  }

  // ignore: unused_element
  _pickTime() async {
    // ignore: unused_local_variable
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(context: context, initialTime: time);

    if (newTime == null) return;
    setState(() {
      time = newTime;
    });
  }
}
