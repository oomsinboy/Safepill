import 'package:flutter/material.dart';
import 'package:flutter_application_1/test/res/custom_colors.dart';
import 'package:flutter_application_1/test/widgets/add_item_form.dart';

class AddScreen extends StatelessWidget {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _heartrate = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: CustomColors.firebaseNavy,
//  drawer: Navigalist(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF3a73b5),

          title: Text("บันทึกค่าความดันโลหิตของคุณ"),
          //title: AppBarTitle(),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: AddItemForm(
              titleFocusNode: _titleFocusNode,
              descriptionFocusNode: _descriptionFocusNode,
              heartrate: _heartrate,
            ),
          ),
        ),
      ),
    );
  }
}
