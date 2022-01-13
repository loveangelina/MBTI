import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbti/mbtiSelectPage.dart';


/*
* SignUpPage
*   회원가입시 Authentication 에 user 추가
*   Fire store database > users collection > user id document
* */

// Firebase Auth
import 'package:firebase_auth/firebase_auth.dart';
class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SingUpPage',
      home: SignUp(),
      theme: ThemeData(
          primaryColor: Colors.black
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  String Nickname = '닉네임';
  // Create new Firebase Auth instance
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  bool isCorrectPassword(){
    return confirmPwController.text == pwController.text;
  }

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
        child: ListView(
          children: [
            SizedBox(height: 20),
            Text('개인정보를 입력하세요', textAlign: TextAlign.center, textScaleFactor: 1.2, ),
            profileImage(),
            SizedBox(height: 20),
            Column(
              children: [
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
                const SizedBox(height: 12),
                Container(
                  width: 350,
                  child: TextFormField(
                    validator: (value) {
                      if (confirmPwController.text != pwController.text) {
                        return '비밀번호가 같지 않습니다';
                      }
                      return null;
                    },
                    onChanged: (text){
                      setState(() {
                        isCorrectPassword();
                      });
                    },
                    controller: confirmPwController,
                    decoration: const InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red
                        ),
                      ),
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Confirm Password'
                    ),
                    obscureText: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            progressCircle(),
            ButtonBar(
              children: [
                ElevatedButton(
                  child: Text('다음단계'),
                  onPressed: () async {
                    if(isCorrectPassword()){
                      try {
                        UserCredential userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: idController.text,
                            password: pwController.text
                        ).whenComplete(() => print('create user'));

                        // collection[users]
                        await FirebaseFirestore.instance.collection('users').doc(idController.text).set({
                          'id' : idController.text,
                        }
                        );
                        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.email).update({'Nickname': Nickname});
                        print(userCredential.user?.email.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => mbtiSelectPage()),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: new Text("오류"),
                                content: new Text("비밀번호가 너무 짧습니다."),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("Close"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: new Text("오류"),
                                content: new Text("아이디가 이미 존재합니다."),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("Close"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                    else{showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: new Text("인증오류"),
                          content: new Text("비밀번호가 다릅니다."),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("Close"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    }
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
            ),
          ],
        ),
      ),
    );
  }

  Widget progressCircle(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 13,
          width: 13,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black
          ),
        ),
        SizedBox(width: 3,),
        Container(
          height: 13,
          width: 13,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black)
          ),
        ),
        SizedBox(width: 3,),
        Container(
          height: 13,
          width: 13,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black)
          ),
        ),
      ],
    );
  }
  Widget profileImage(){
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2016/11/14/09/14/cat-1822979_1280.jpg'
                    ),
                  )
              ),
              margin: EdgeInsets.all(20),
            ),
            Positioned(
              child: Icon(
                Icons.photo_camera,
                size: 40,
              ),
              top: 190,
              left: 160,
            )
          ],
        ),
        Row(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            SizedBox(width: 40,),
            Text(Nickname, textScaleFactor: 1.3,),
            IconButton(
              icon: Icon(Icons.create), onPressed: () {
              print('fuck');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    title: new Text("닉네임을 입력하세요"),
                    content: TextField(
                      controller: nickNameController,

                    ),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Ok"),
                        onPressed: () {
                          setState(() {
                            Nickname = nickNameController.text;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            )
          ],
        ),
      ],
    );
  }

  Widget inputfield(){
    return Column(
      children: [
        Container(
          width: 350,
          child: TextField(
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
            controller: idController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Password'
            ),
            obscureText: true,
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
                labelText: 'Confirm Password'
            ),
            obscureText: true,
          ),
        ),
      ],
    );
  }

  Widget nextButtonArea(){
    return ButtonBar(
      children: [
        ElevatedButton(
          child: Text('다음단계'),
          onPressed: () async {
            try {
              print("다음 단계");
              UserCredential userCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                  email: idController.text,
                  password: pwController.text
              ).whenComplete(() => print('create user'));
              print('Nickname');

              print(userCredential.user!.email);

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