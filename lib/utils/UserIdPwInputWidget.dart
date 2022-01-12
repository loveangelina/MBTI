import 'package:flutter/material.dart';


// 유저 id, pw 입력에 사용되는 TextField 위젯
class UserIdPwInputWidget extends StatelessWidget {
  const UserIdPwInputWidget({Key? key}) : super(key: key);
  
  // 리스트에 TextField 를 미리 담아둠 
  final List<Widget> _userIdPwEntries = const [
    InputWidget(
      label: "Username",
    ),
    Divider(color: Colors.white,),
    InputWidget(label: "Password")
  ];

  // build 작업시에 Column 에 생성해둔 리스트를 뿌려줌
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _userIdPwEntries,
    );
  }
}

class InputWidget extends StatelessWidget {
  final String label;

  const InputWidget({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextField(
        decoration: InputDecoration(
            border: const OutlineInputBorder(), filled: true, labelText: label),
      ),
    );
  }
}
