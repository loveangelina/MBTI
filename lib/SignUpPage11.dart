import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbti/mbtiSelectPage.dart';

import 'package:mbti/utils/ProfileImageWidget.dart';
import 'package:mbti/utils/UserIdPwInputWidget.dart';

// Firebase Auth
import 'package:firebase_auth/firebase_auth.dart';

// 회원가입
// controller 에서 data 들을 관리

/*

  SignUpPage -> mbtiSelectPage -> CategorySelectPage
      controller 를 전달하기  -> HomePage

 */
class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SingUpPage',
      home: SignUp(),
      theme: ThemeData(primaryColor: Colors.black),
    );
  }
}

class ProgressCircleWidget extends StatelessWidget {
  const ProgressCircleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 13,
          width: 13,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        ),
        SizedBox(
          width: 3,
        ),
        Container(
          height: 13,
          width: 13,
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: Colors.black)),
        ),
        SizedBox(
          width: 3,
        ),
        Container(
          height: 13,
          width: 13,
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: Colors.black)),
        ),
      ],
    );
  }
}
//
class NextButtonAreaWidget extends StatelessWidget {
  List<TextEditingController> textControllerList;

  NextButtonAreaWidget({Key? key, required this.textControllerList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: [
        ElevatedButton(
          child: Text('다음단계'),
          onPressed: () async {
            try {
              UserCredential userCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: textControllerList[0].text,
                      password: textControllerList[1].text);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => mbtiSelectPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        )
      ],
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  // final TextEditingController idController = TextEditingController();
  // final TextEditingController pwController = TextEditingController();

  static List<TextEditingController> controllerList = [TextEditingController(), TextEditingController()];

  // Create new Firebase Auth instance
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    controllerList[0].dispose();
    controllerList[1].dispose();
    // idController.dispose();
    // pwController.dispose();
    super.dispose();
  }

  List<Widget> _signUpEntries = [
    Text(
      '개인정보를 입력하세요',
      textAlign: TextAlign.center,
      textScaleFactor: 1.2,
    ),
    ProfileImageWidget(),
    UserIdPwInputWidget(
      textControllerList: controllerList,
    ),
    ProgressCircleWidget(),
    NextButtonAreaWidget(textControllerList: controllerList),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: _signUpEntries.length,
            itemBuilder: (BuildContext context, int index) {
              return _signUpEntries[index];
            },
            // Divider class 를 사용해 구분해줌
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  color: Colors.white,
                )),
      ),
    );
  }
}
