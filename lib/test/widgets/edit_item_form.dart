import 'package:flutter/material.dart';

import 'package:flutter_application_1/test/res/custom_colors.dart';
import 'package:flutter_application_1/test/utils/database.dart';
import 'package:flutter_application_1/test/utils/validator.dart';

import 'custom_form_field.dart';

class EditItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  final FocusNode heartrate;
  final String currentTitle;
  final String currentDescription;
  final String currentheartrate;
  final String documentId;

  const EditItemForm({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
    required this.heartrate,
    required this.currentTitle,
    required this.currentDescription,
    required this.currentheartrate,
    required this.documentId,
  });

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _heartrate;

  @override
  void initState() {
    _titleController = TextEditingController(
      text: widget.currentTitle,
    );

    _descriptionController = TextEditingController(
      text: widget.currentDescription,
    );

    _heartrate = TextEditingController(text: widget.currentheartrate);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _editItemFormKey,
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
                      label: 'Title',
                      hint: 'mmHg',
                    ),
                    SizedBox(height: 24.0),
                    Text(
                      'อัตราการเต้นของหัวใจ',
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
                      hint: '/นาที',
                    ),
                  ],
                ),
              ),
              _isProcessing
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          CustomColors.firebaseOrange,
                        ),
                      ),
                    )
                  : Container(
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

                          if (_editItemFormKey.currentState!.validate()) {
                            setState(() {
                              _isProcessing = true;
                            });

                            await Database.updateItem(
                                docId: widget.documentId,
                                title: _titleController.text,
                                description: _descriptionController.text,
                                heartrate: _heartrate.text,
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
                              // color: CustomColors.firebaseGrey,
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
}
