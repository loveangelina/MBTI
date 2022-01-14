import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  Stream<QuerySnapshot> chatRoomStream = FirebaseFirestore.instance
      .collection('users').where('roomTitle', isEqualTo: '채팅방 이름')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Container(), // 뒤로가기 버튼 삭제
          backgroundColor: Colors.white,
          title: const Padding(
            child: Text(
              '채팅',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: EdgeInsets.only(right: 10),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: chatRoomStream,
          builder: (context, snapshot) {
            print(snapshot.data);
            return ListView(
              children: [
                //chatRoom(opponentID: ''),
                Divider(),
                Divider(),
              ],
            );
          }
        )
    );
  }
}
/*
class chatRoom extends StatelessWidget {
  final String opponentID;
  chatRoom({Key? key, required this.opponentID}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // get the course document using a stream
    Stream<QuerySnapshot> courseDocStream = FirebaseFirestore.instance
        .collection('users').where('users', isEqualTo: opponentID)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: courseDocStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {

            var user = snapshot.data!.data();
            var nickName = (user as dynamic)['nickName'];
            var url = (user as dynamic)['profileURL'] ?? '';

            return ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(url) ?? Image.asset('name')
                            ),
                            color: Colors.black87,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(nickName),
                            SizedBox(height: 20,),
                            Text('내용'),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('오후 12:47'),
                        SizedBox(height: 10,),
                        Chip(
                          backgroundColor: Color(0xFFEAEAEA),
                          label: Text('4'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}*/