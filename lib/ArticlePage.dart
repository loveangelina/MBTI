import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';

import './model/article.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key, required this.article}) : super(key: key);

  final Article article;
  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  final auth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final Article article = widget.article;
    return Scaffold(
      appBar: appBarSection(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          titleSection(),
          contentSection(),
          tagSection(),
          likeAndCommentSection(),
          advertisementSection(),
          // Container(
          //   height: 200,
          //   child: ListView.builder(
          //       itemBuilder:
          //   ),
          // )
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
  Widget titleSection() {
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
              const Text(
                'userName',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: const Text(
                  'title',
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
  Widget contentSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: const Text(
        'content',
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
  Widget likeAndCommentSection() {
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
                const Text(
                    'count of likes'
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
                const Text(
                    'count of comments'
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
            Icons.more_vert,
          ),
          onPressed: () {

          },
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
        )
      ],
    );
  }




  //generate comment v1
  Widget generateComment(String content, String userName, String userImgURL) {
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
              Text(userName),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  content,
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
            Icons.more_vert,
          ),
          onPressed: () {

          },
        ),
        const Divider(
          color: Colors.black,
          thickness: 2,
        )
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