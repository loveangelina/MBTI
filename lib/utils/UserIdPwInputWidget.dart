import 'package:flutter/material.dart';


// 유저 id, pw 입력에 사용되는 TextField 위젯
class UserIdPwInputWidget extends StatefulWidget {
  final List<TextEditingController> textControllerList;
  UserIdPwInputWidget({Key? key, required this.textControllerList}) : super(key: key);
  @override
  State<UserIdPwInputWidget> createState() => _UserIdPwInputWidgetState();
}

class _UserIdPwInputWidgetState extends State<UserIdPwInputWidget> {
  late List<Widget> _userIdPwEntries;
  _UserIdPwInputWidgetState() {
    _userIdPwEntries = [
      InputWidget(controller: widget.textControllerList[0], label: "Username"),
      Divider(color: Colors.white),
      InputWidget(controller: widget.textControllerList[1], label: "Password"),
      // Divider(color: Colors.white,),
      // InputWidget(label: "Confirm Password")
    ];
  }


  // 리스트에 TextField 를 미리 담아둠
  // List<Widget> _userIdPwEntries =  [
  //   // InputWidget(
  //   //   label: "Username",
  //   //   widget.textControllerList[0],
  //   // ),
  //   InputWidget(controller: widget.textControllerList[0], label: "Username"),
  //   Divider(color: Colors.white,),
  //   InputWidget(label: "Password", controller: null,),
  //   // Divider(color: Colors.white,),
  //   // InputWidget(label: "Confirm Password")
  // ];
  //

  // build 작업시에 Column 에 생성해둔 리스트를 뿌려줌
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _userIdPwEntries,
    );
  }
}

class InputWidget extends StatefulWidget {
  TextEditingController controller;
  final String label;
  InputWidget({Key? key, required this.label, required this.controller}) :super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(), filled: true, labelText: widget.label),
      ),
    );
  }
}
