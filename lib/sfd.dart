import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  /*
   * use your firebase configuration
   * await Firebase.initializeApp(
       options: const FirebaseOptions(
           apiKey: "AIzaSyCbxqPMZaWbPtwY_LaddkoUuQC_-RZZ4vo",
           authDomain: "unitwin-b11a6.firebaseapp.com",
           projectId: "unitwin-b11a6",
           storageBucket: "unitwin-b11a6.appspot.com",
           messagingSenderId: "1075604622349",
           appId: "1:1075604622349:web:fab6b03348000925051944"
    ));
  */
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chapter 5 practice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            color: Colors.white,
          )),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 35, right: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                child: Container(),
              ),
              const FlutterLogo(size:100),
              SizedBox(
                height: 100,
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  obscureText: true,
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      loginWithIdandPassword();
                      emailController.clear();
                      passwordController.clear();
                    },
                    child: Text('Login')),
              ),
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  TextButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.grey),
                      ))
                ],
              )
            ],
          ),
        ));
  }


  Future<void> loginWithIdandPassword() async {
    try {
      // sign in with email and password using signInWithEmailAndPassword()
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // navigate to Homepage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChattingPage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No user found for that email'),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'exit',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ));

        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          // step 3: set SnackBar content, duration and action
            SnackBar(
              content: Text('Wrong password provided for that user.'),
              duration: Duration(seconds: 2),
              action: SnackBarAction(
                label: 'exit',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ));

        print('Wrong password provided for that user.');
      }
    }
  }
}

enum Gender { man, woman }

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.keyboard_backspace),
        ),
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            signUpTextFormField('Name', nameController),
            signUpTextFormField('email', emailController),
            passwordTextFormField('Password', passwordController),
            practice2(),
            practice3(),
            practice4(),
            practice5(),
            practice6(),
          ],
        ),
      ),
    );
  }

  // practice 1: make TextFormField
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Widget signUpTextFormField(String name, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 20),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 15),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
                hintText: name,
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.zero),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $name';
              }
              return null;
            },
          ),
        )
      ],
    );
  }

  Widget passwordTextFormField(String name, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 20),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 15),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
                hintText: name, contentPadding: EdgeInsets.zero),
            obscureText: true,
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Please enter more than 6 words';
              }
              return null;
            },
          ),
        )
      ],
    );
  }

  // practice 2: make date picker
  DateTime currentDate = DateTime.now();

  Widget practice2() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Birth',
            style: TextStyle(fontSize: 20),
          ),
          Expanded(child: SizedBox()),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
              ),
              onPressed: () {
                // 난이도 중 밑은 selectedDate부분만 코딩하는 거로!
                selectedDate();
              },
              child: Row(
                children: [
                  Text(
                    currentDate.year.toString() +
                        '/' +
                        currentDate.month.toString() +
                        '/' +
                        currentDate.day.toString(),
                    style: TextStyle(color: Colors.black26),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.calendar_today, color: Colors.black26)
                ],
              ))
        ],
      ),
    );
  }

  Future<void> selectedDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2030));

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  // practice 3: make radio button
  Gender _gender = Gender.man;
  Widget practice3() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender',
            style: TextStyle(fontSize: 20),
          ),
          Row(
            children: <Widget>[
              Radio<Gender>(
                  value: Gender.man,
                  groupValue: _gender,
                  onChanged: (Gender? value) {
                    setState(() {
                      _gender = value!;
                    });
                  }),
              Text('Male'),
              Radio<Gender>(
                  value: Gender.woman,
                  groupValue: _gender,
                  onChanged: (Gender? value) {
                    setState(() {
                      _gender = value!;
                    });
                  }),
              Text('Female'),
            ],
          )
        ],
      ),
    );
  }

  // practice 4: make dropdown menu
  var dropDownList = ['Highschool', 'University', 'Colleage', 'Graduate'];
  var dropDownListValue = 'Highschool';

  Widget practice4() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        children: [
          Text(
            'Current Education',
            style: TextStyle(fontSize: 20),
          ),
          Expanded(child: SizedBox()),
          DropdownButton<String>(
            value: dropDownListValue,
            items: dropDownList.map((String value) {
              return DropdownMenuItem(
                child: Text(value),
                value: value,
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                dropDownListValue = value.toString();
              });
            },
          )
        ],
      ),
    );
  }

  // practice 5: make switch
  bool _isSwithChecked = false;
  Widget practice5() {
    return Padding(
      padding: const EdgeInsets.only(top: 75, bottom: 15),
      child: Row(
        children: [
          Text(
            'Reveal to the public',
            style: TextStyle(fontSize: 20),
          ),
          Expanded(child: SizedBox()),
          Switch(
            value: _isSwithChecked,
            onChanged: (value) {
              setState(() {
                _isSwithChecked = value;
              });
            },
          )
        ],
      ),
    );
  }

  // practice 6: make ElevatedButton
  Widget practice6() {
    return Container(
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if(_formkey.currentState!.validate()){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('preview'),
                    content: Container(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: ' + nameController.text),
                          Text('Password: ' + passwordController.text),
                          Text('Birth: ' +
                              currentDate.year.toString() +
                              '/' +
                              currentDate.month.toString() +
                              '/' +
                              currentDate.day.toString()),
                          Text(_gender.toString() == 'Gender.man'
                              ? 'Gender: Man'
                              : 'Gender: Woman'),
                          Text('Current Education: ' + dropDownListValue),
                          Text('Reveal to the public: ' +
                              _isSwithChecked.toString()),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            signUpWithEmailandPassword();
                          },
                          child: Text(
                            'save',
                            style: TextStyle(color: Colors.blue),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'exit',
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  );
                });
          }
        },
        child: Text(
          'Join',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> signUpWithEmailandPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      FirebaseFirestore.instance
          .collection('user')
          .doc(emailController.text)
          .set({
        'name': nameController.text,
        'email': emailController.text,
        'birth': currentDate.year.toString() +
            '/' +
            currentDate.month.toString() +
            '/' +
            currentDate.day.toString(),
        'gender': _gender.toString() == 'Gender.man' ? 'Man' : 'Woman',
        'currentEducation': dropDownListValue,
        'revealToThePublic': _isSwithChecked // we can use bool type
      })
          .then((value) => print('User Added'))
          .catchError((error) => print('Failed to add user: $error'));

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginPage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('The account already exists for that email.'),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'exit',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ));

        Navigator.of(context).pop();
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}

class ChattingPage extends StatefulWidget {
  const ChattingPage({Key? key}) : super(key: key);

  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String name;
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(auth.currentUser!.email);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat Room',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance
                    .signOut()
                    .whenComplete(() => Navigator.of(context).pop());
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chat')
                    .orderBy('timeStamp', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('$snapshot.error'));
                  } else if (!snapshot.hasData)
                    return LinearProgressIndicator();
                  else {
                    return ListView(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, top: 20, bottom: 20),
                      children: snapshot.data!.docs
                          .map((DocumentSnapshot data) => _buildChat(data))
                          .toList(),
                    );
                  }
                }),
          ),
          const Divider(
            height: 1,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.infinity,
            height: 80,
            child: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('user')
                    .doc(auth.currentUser!.email)
                    .get(),
                builder: (context, data) {
                  String dayTime = int.parse(DateTime.now().hour.toString()) < 12 ? 'am' : 'pm';
                  String showTime = dayTime + ' ' + DateTime.now().hour.toString() +
                      ':' +
                      DateTime.now().minute.toString();
                  if(!data.hasData){
                    return Container();
                  } else {
                    return Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              controller: contentController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: Colors.black12))),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              String cid = DateTime.now().toString();
                              FirebaseFirestore.instance
                                  .collection('chat')
                                  .doc(cid)
                                  .set({
                                'name': data.data!['name'],
                                'timeStamp': DateTime.now(),
                                'showTime': showTime,
                                'email': auth.currentUser!.email,
                                'content': contentController.text,
                                'cid': cid,
                              }).whenComplete(() {
                                print('chat add');
                                contentController.clear();
                              });
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.blue,
                            )),
                      ],
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget _buildChat(DocumentSnapshot data) {
    Chat _chat = Chat.fromDs(data);

    return _chat.email == auth.currentUser!.email
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(_chat.showTime),
            Flexible(
              child: Container(
                // width: 300,
                child: InkWell(
                  onLongPress: () {
                    showDialog(context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Press Yes to delete message'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance.collection('chat').doc(_chat.cid).delete();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.lightBlueAccent),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ],
                          );
                        }
                    );
                  },
                  child: Card(
                    elevation: 4,
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        _chat.content,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    )
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _chat.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Row(
          children: [
            Flexible(
              child: Container(
                // width: 300,
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(_chat.content),
                  ),
                ),
              ),
            ),
            Text(_chat.showTime)
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class Chat {
  String email;
  String name;
  String showTime;
  String content;
  String cid;

  Chat({required this.email,required this.name, required this.showTime,required this.content, required this.cid});

  factory Chat.fromDs(dynamic data) {
    return Chat(
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      showTime: data['showTime'] ?? '',
      content: data['content'] ?? '',
      cid: data['cid'] ?? '',
    );
  }
}