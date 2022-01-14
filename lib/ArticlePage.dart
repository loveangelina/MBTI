import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';
import 'package:intl/intl.dart';

import './model/article.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key, required this.article}) : super(key: key);

  final Article article;
  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  final auth = FirebaseAuth.instance.currentUser;
  late String? currId;
  late int commentCount;

  @override
  Widget build(BuildContext context) {
    final Article article = widget.article;
    currId = FirebaseAuth.instance.currentUser?.email;
    List topic = article.topic;
    // commentCount = FirebaseFirestore.instance.collection('article').doc(article.aid).collection('comment').snapshots().length;
    // print(article.aid);
    // print(FirebaseAuth.instance.currentUser);
    // print(currId);
    return Scaffold(
      appBar: appBarSection(),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                titleSection(article.createrId, article.post['title']),
                contentSection(article.post['content']),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Container(
                  height: 100,
                  child: Center(
                    child: GridView.count(
                      crossAxisCount: 4,
                      children: List.generate(
                          topic.length, (index) => generateChip(topic[index])
                      ),
                    ),
                  ),
                ),
                likeAndCommentSection(article.like, 0),
                advertisementSection(),
                Container(
                  height: 200,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('article').doc(article.aid).collection('comment').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container();
                      }else {
                        // print(snapshot.data!.docs);
                        return ListView(
                          children: List.generate(snapshot.data!.docs.length, (index) => generateComment(snapshot.data!.docs[index]))
                        );
                      }
                    },
                  ),
                ),
                // commentSection(),

              ],
            ),
          ),
          _buildTextComposer(article.aid, currId),
        ],
      ),
    );
  }

  //appbar
  PreferredSizeWidget appBarSection() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage()
              )
          );
        },
      ),
      title: const Text(
        '게시글',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  //title and poster section
  Widget titleSection(String? userName, String? title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: const Icon(
            Icons.circle,
            size: 70,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName ?? '임시',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  title ?? '임시',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const Text(
                'timeStamp',
              )
            ],
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.more_vert,
          ),
          onPressed: () {

          },
        ),
      ],
    );
  }

  //content section
  Widget contentSection(String? content) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: Text(
        content ?? '임시',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  //tag section - required adding chip
  Widget tagSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: const Icon(
            Icons.circle,
          ),
        ),
      ],
    );
  }

  //like count and comment count
  Widget likeAndCommentSection(int likes, int commentCount) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 7),
            child: Row(
              children: [
                const Icon(
                  Icons.thumb_up_alt,
                ),
                Text(
                    likes.toString()
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Icon(
                  Icons.chat_bubble_outline,
                ),
                Text(
                    commentCount.toString()
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //advertisement section
  Widget advertisementSection() {
    return Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://cdn.pixabay.com/photo/2016/11/14/09/14/cat-1822979_1280.jpg'),
          )
      ),
    );
  }

  //temp comment
  Widget commentSection() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: const Icon(
            Icons.account_circle_rounded,
            size: 50,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('userName'),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: const Text(
                  'content',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.chat_bubble,
          ),
          onPressed: () {

          },
        ),
        const Divider(
          color: Colors.grey,
          thickness: 1,
        )
      ],
    );
  }


  Widget comment() {
    return Row(

    );
  }

  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  Widget _buildTextComposer(String aid, String? uid) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                // onSubmitted: _isComposing ? () => _handleSubmitted(_textController.text, aid, uid) : null,
                decoration:
                InputDecoration.collapsed(hintText: "댓글을 작성하세요"),
              ),
            ),
            // 전송 버튼
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text, aid, uid)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 메시지 전송 버튼이 클릭될 때 호출
  void _handleSubmitted(String text, String aid, String? uid) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    setState(() {
      addComment(text, aid, uid);
    });
  }

  Future<void> addComment(String content, String aid, String? uid) async {
    // print(content);
    // print(aid);
    // print(uid);
    await FirebaseFirestore.instance.collection('article').doc(aid).collection('comment').add({
      'content' : content,
      'userId' : uid,
      'time' : DateFormat('yy/MM/dd - HH:mm:ss').format(DateTime.now()),
    });
  }

  Future<void> createChatroom(String commenterId, String? currId) async{
    String chatRoom = 'temp';
    String RoomTitle = 'temp';
    if (currId != null && commenterId != null) {
      chatRoom = currId + '|' + commenterId;
      RoomTitle = currId + '님과 ' + commenterId + '님의 채팅방';
    }

    // print(chatRoom);

    await FirebaseFirestore.instance.collection('chatRooms').doc(chatRoom).set({
      'RoomTitle' : RoomTitle,
      'users' : [currId, commenterId],
    });
  }

  //generate comment v1
  Widget generateComment(DocumentSnapshot data) {
    ArticleComments articleComments = ArticleComments.fromDs(data);
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.account_circle_rounded,
                size: 50,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(articleComments.userId),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      articleComments.content,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.chat_bubble,
              ),
              onPressed: () {
                createChatroom(articleComments.userId, currId);

                String chatRoom = 'temp';
                if (currId != null && articleComments.userId != null) {
                  chatRoom = currId!+'|'+articleComments.userId;
                }

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const ChatRoomPage(chatRoom)),
                // );
              },
            ),
          ],
        ),
        const Divider(
          color: Colors.grey,
          thickness: 1,
        ),
      ],
    );
  }

  //generate chip v1
  Widget generateChip(String chipName) {
    return Chip(
      label: Text(chipName),
      backgroundColor: const Color(0xFFEAEAEA),
    );
  }
}