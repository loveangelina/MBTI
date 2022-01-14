import 'package:flutter/material.dart';
import 'package:mbti/utils/ProfileImageWidget.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  // 리스트에 각각의 위젯을 담아서 build 함수에서 뿌려주는 방식
  // final List<Widget> _myPageEntries = [
  //   const ProfileImageWidget(),
  //   UserIdPwInputWidget(textControllerList: [],),
  //   UserDropDownWidget(
  //     items: ["ENFJ", "INFJ", "ISTP"],
  //     dropdownValue: "ENFJ",
  //   ),
  //   const Text("관심사 : TODO ... 해야하는데 어케 할지 모르게쒀요"),
  //   Row(children: <Widget>[
  //     Expanded(
  //         child: Align(
  //             alignment: Alignment.centerLeft,
  //             child: ElevatedButton(
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
  //               ),
  //               onPressed:  () {},
  //               child: Text('탈퇴'),
  //             ))),
  //     Expanded(
  //         child: Align(
  //             alignment: Alignment.centerRight,
  //             child: ElevatedButton(
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
  //               ),
  //               onPressed: () {},
  //               child: Text('저장'),
  //             ))),
  //   ])
  // ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              '마이 페이지',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: ListView(
            children: [
              ProfileImageWidget(),
              Container(
                width: 350,
                child: TextField(
                  controller: idController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Username'
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 350,
                child: TextField(
                  controller: pwController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Password'
                  ),
                  obscureText: true,
                ),
              ),
              UserDropDownWidget(
                items: ["ENFJ", "INFJ", "ISTP"],
                dropdownValue: "ENFJ",
              ),
              const Text("관심사 : TODO ... 해야하는데"),
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
                          onPressed: () async {
                            FirebaseAuth.instance.currentUser?.updatePassword(pwController.text);
                            FirebaseAuth.instance.currentUser?.updatePassword(pwController.text);
                            await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.email).set({
                              'id' : idController.text,
                            });

                            print(pwController.text);
                            print(idController.text);

                          },
                          child: Text('저장'),
                        ))),
              ])
            ],
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
