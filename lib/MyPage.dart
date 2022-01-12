import 'package:flutter/material.dart';
import 'package:mbti/utils/ProfileImageWidget.dart';
import 'package:mbti/utils/UserIdPwInputWidget.dart';

/*
  gihwan-kim
 */
class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyPageWidget(),
    );
  }
}

/*
  마이페이지 위젯
 */
class MyPageWidget extends StatefulWidget {
  const MyPageWidget({Key? key}) : super(key: key);

  @override
  State<MyPageWidget> createState() => _MyPageWidgetState();
}

class _MyPageWidgetState extends State<MyPageWidget> {
  ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  // 리스트에 각각의 위젯을 담아서 build 함수에서 뿌려주는 방식
  final List<Widget> _myPageEntries = [
    const ProfileImageWidget(),
    const UserIdPwInputWidget(),
    UserDropDownWidget(
      items: ["ENFJ", "INFJ", "ISTP"],
      dropdownValue: "ENFJ",
    ),
    const Text("관심사 : TODO ... 해야하는데 어케 할지 모르게쒀요"),
    Row(children: <Widget>[
      Expanded(
          child: Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed:  () {},
                child: Text('탈퇴'),
              ))),
      Expanded(
          child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () {},
                child: Text('저장'),
              ))),
    ])
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          title: const Text(
            '마이 페이지',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: _myPageEntries.length,
          itemBuilder: (BuildContext context, int index) {
            return _myPageEntries[index];
          },
          // Divider class 를 사용해 구분해줌
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.white,
          ),
        )));
  }
}

/*
  [UserDropDownWidget]
    DropDownWidget 생성하는 class
    items 를 argument 로 넣어줘야함
    userValue : 유저의 값 (MBTI 유형)
 */
class UserDropDownWidget extends StatefulWidget {
  final List<String> items;
  String dropdownValue;

  UserDropDownWidget(
      {Key? key, required this.items, required this.dropdownValue})
      : super(key: key);

  @override
  State<UserDropDownWidget> createState() => _UserDropDownWidgetState();
}

class _UserDropDownWidgetState extends State<UserDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: DropdownButton<String>(
        value: widget.dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            widget.dropdownValue = newValue!;
          });
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
