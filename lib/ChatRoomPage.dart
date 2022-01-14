import 'dart:async';

// TODO 채팅탭
// TODO 채팅방

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// firebase
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Provider
//   Consumer<ApplicationState>

// chat room layout
class ChatRoomPage extends StatelessWidget {
  // chatRooms > chatRoom : 단일 채팅방 document 이름
  final String chatRoomDocName;
  final String chatRoomTitle;
  late String currentUserNickName;
  late String? userId;

  ChatRoomPage(
      {Key? key, required this.chatRoomDocName, required this.chatRoomTitle})
      : super(key: key);

  void nickNameGenerator(BuildContext context) async {
    userId = FirebaseAuth.instance.currentUser!.email;
    final data = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => {value.data()});
    data.then((val) {
      final myMap = val.elementAt(0);
      currentUserNickName = myMap?["nickName"];
    });
  }

  @override
  Widget build(BuildContext context) {
    nickNameGenerator(context);
    // ChangeNotifierProvider : 자식들에게 changeNotifier 인스턴스를 제공
    return (ChangeNotifierProvider<ApplicationState>(
      create: (context) => ApplicationState(chatRoomDocName),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'chat room title',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[
            // Consumer : ApplicationState 에 접근
            Consumer<ApplicationState>(
              // builder : ChangeNotifier 가 변경될때마다 호출되는 함수
              builder: (context, appState, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChatRoom(
                    addMessage: (message) => appState.addMessageToChatRoom(
                        message, chatRoomDocName, currentUserNickName),
                    messages: appState._chatRoomMessages,
                    currentUserId: userId,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

/*
  [display message]
    listener
      data 수정 및 새로운 message 발생시 ui element 생성해주는 코드
*/
class ChatRoomMessage {
  ChatRoomMessage(
      {required this.nickName,
      required this.message,
      required this.timeStamp,
      required this.userId});

  final String userId;
  final String timeStamp;
  final String nickName;
  final String message;
}

class ApplicationState extends ChangeNotifier {
  ApplicationState(String chatRoomDocName) {
    init(chatRoomDocName);
  }

  StreamSubscription<QuerySnapshot>? _chatRoomSubscription;
  List<ChatRoomMessage> _chatRoomMessages = [];

  List<ChatRoomMessage> get chartRoomMessages => _chatRoomMessages;

  // Add from here
  // 해당 채팅방 document 의 messages collection 에 메시지(document) 추가
  Future<DocumentReference> addMessageToChatRoom(
      String message, String chatRoomDocName, String nickName) {
    return FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatRoomDocName)
        .collection("messages")
        .add(<String, dynamic>{
      'message': message,
      'timestamp': DateFormat('yy/MM/dd - HH:mm:ss').format(DateTime.now()),
      'nickName': nickName,
      'id': FirebaseAuth.instance.currentUser!.email
    });
  }

// To here
  Future<void> init(String chatRoomDocName) async {
    _chatRoomSubscription = FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatRoomDocName)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((snapshot) {
      _chatRoomMessages = [];
      for (final document in snapshot.docs) {
        _chatRoomMessages.add(
          ChatRoomMessage(
              nickName: document.data()['nickName'],
              message: document.data()['message'],
              timeStamp: document.data()['timestamp'],
              userId: document.data()['id']),
        );
      }
      // 데이터 가져왔으니까 state 바꼈다고 notifyListeners() 호출
      notifyListeners();
    });
  }
}

/*
  state 변화를 user interface 에 연결하기 위해
    widget 에 message list (=messages) 를 추가
*/
class ChatRoom extends StatefulWidget {
  // message list
  const ChatRoom(
      {required this.addMessage,
      required this.messages,
      required this.currentUserId});

  final String? currentUserId;

  final List<ChatRoomMessage> messages;

  final FutureOr<void> Function(String message) addMessage;

  // const
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

// [write message]
class _ChatRoomState extends State<ChatRoom> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_ChatRoomState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("widget.currentUserId");
    int idx = 0;
    for (var message in widget.messages) {
      print("-----------------------------");
      print(idx);
      print(widget.currentUserId);
      print(message.userId);
      idx++;
    }
    return Column(
      // Column 일 경우 왼쪽 세로 정렬
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        // message list 에 있던 것 생성해주기
        for (var message in widget.messages)
          if (widget.currentUserId == message.userId)
            MyMessageWidget('${message.nickName}: ${message.message}',
                  message)
          else OtherMessageWidget('${message.nickName}: ${message.message}',
                  message),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintText: '메시지 입력',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message to continue';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                StyledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget.addMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.send, color: Colors.black,),
                      SizedBox(width: 4),
                      Text('SEND', style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed});

  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.black)
        ),
        onPressed: onPressed,
        child: child,
      );
}

// 본인 채팅 : end
class MyMessageWidget extends StatelessWidget {
  const MyMessageWidget(this.text, this.chatRoomMessage);

  final ChatRoomMessage chatRoomMessage;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // name 설정
          Text(chatRoomMessage.nickName),
          // message, time 설정
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // time
              Text(chatRoomMessage.timeStamp),
              // message : 유동적인 사이즈
              Flexible(
                  child: Container(
                    child: Card(
                      color: Colors.white,
                      // shadow
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(chatRoomMessage.message),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}


// 다른 사람 : start
class OtherMessageWidget extends StatelessWidget {
  const OtherMessageWidget(this.text, this.chatRoomMessage);

  // 본인 채팅 : end
  // 다른 사람 : start
  final ChatRoomMessage chatRoomMessage;
  final String text;

  @override
  Widget build(BuildContext context) {
    // print("alignType");
    // print(alignType);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // name 설정
          Text(chatRoomMessage.nickName),
          // message, time 설정
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // message : 유동적인 사이즈
              Flexible(
                  child: Container(
                    child: Card(
                      color: Colors.white,
                      // shadow
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(chatRoomMessage.message),
                      ),
                    ),
                  )),
              // time
              Text(chatRoomMessage.timeStamp)
            ],
          ),
        ],
      ),
    );
  }
}


