import 'package:flutter/material.dart';

class alarmTab extends StatefulWidget {
  const alarmTab({Key? key}) : super(key: key);

  @override
  State<alarmTab> createState() => _alarmTabState();
}

class _alarmTabState extends State<alarmTab> {
  bool _isDeleted = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          )
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0, // AppBar 그림자 제거
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            bottom: const TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child:Text("활동 알림"),
                    )
                ),Tab(text: "키워드 알림"),
              ],
              indicatorColor: Colors.black,
            ),
            automaticallyImplyLeading: true,
            leading: IconButton(icon: const Icon(Icons.arrow_back),
              onPressed: () {  },),
            title: const Text('알림'),
            actions: [
              IconButton(
                icon: Icon(
                  _isDeleted ? Icons.check : Icons.delete,
                      color: Colors.black54,
                      size: 24.0,
                    ),
                onPressed: () {
                  setState(() {
                    _isDeleted = !_isDeleted;
                  });
                },
              )
            ]
          ),
          body: TabBarView(
            children: [
              ListView(
                padding: EdgeInsets.only(top: 10),
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: [
                        Container(
                          child: Row(
                            children:[
                              Container(
                                child: const CircleAvatar(//이미지 수정 필요
                                  backgroundImage: AssetImage('image/logo.png'),
                                  radius:28,
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(left:20),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            child: Row(
                                              children: [
                                                const Icon(
                                                    Icons.favorite,
                                                    color: Colors.pink,
                                                    size: 17.0,
                                                ),
                                                Container(
                                                    width: 230,
                                                    padding: const EdgeInsets.only(left:5),
                                                  child:const Text('호호-ENFJ 님이 좋아요를 등록했어요! 확인하러 가볼까요?',
                                                      style: TextStyle(fontSize: 13))
                                                )
                                              ]

                                            )
                                        ),
                                        Container(
                                            child: const Text('#ENFJ #ENFP #스터디모임',
                                                style: TextStyle(fontSize: 10))
                                        ),
                                        Container(
                                            child: const Text('5분전',
                                                style: TextStyle(fontSize: 10))
                                        ),
                                      ]
                                  )

                              )
                            ]
                          )
                        ),
                        Spacer(),
                        _isDeleted ? IconButton(onPressed: () {}, icon: Icon(Icons.close)) : Container()
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Row(
                      children: [
                        Container(
                            child: Row(
                                children:[
                                  Container(
                                    child: const CircleAvatar(
                                      backgroundImage: AssetImage('image/logo.png'),
                                      radius:28,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(left:20),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.edit,
                                                        color: Colors.black45,
                                                        size: 17.0,
                                                      ),
                                                      Container(
                                                          width: 230,
                                                          padding: const EdgeInsets.only(left:5),
                                                          child:const Text('nhkim-ISFP 님이 댓글을 등록했어요! 확인하러 가볼까요?',
                                                              style: TextStyle(fontSize: 13))
                                                      )
                                                    ]

                                                )
                                            ),
                                            Container(
                                                child: const Text('#ISFP #남매 #고민상담',
                                                    style: TextStyle(fontSize: 10))
                                            ),
                                            Container(
                                                child: const Text('11분전',
                                                    style: TextStyle(fontSize: 10))
                                            ),
                                          ]
                                      )

                                  )
                                ]
                            )
                        ),
                        Spacer(),
                        _isDeleted ? IconButton(onPressed: () {}, icon: Icon(Icons.close)) : Container()
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Row(
                      children: [
                        Container(
                            child: Row(
                                children:[
                                  Container(
                                    child: const CircleAvatar(
                                      backgroundImage: AssetImage('image/logo.png'),
                                      radius:28,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(left:20),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.remove_red_eye,
                                                        color: Colors.black45,
                                                        size: 17.0,
                                                      ),
                                                      Container(
                                                        width: 230,
                                                          padding: const EdgeInsets.only(left:5),
                                                          child:const Text('MBTI별 공부 비법! 명문대 학생들이 전하는 꿀팁! 확인하러 가볼까요?',
                                                              style: TextStyle(fontSize: 13))
                                                      )
                                                    ]

                                                )
                                            ),
                                            Container(
                                                child: const Text('',
                                                    style: TextStyle(fontSize: 10))
                                            ),
                                            Container(
                                                child: const Text('2일전',
                                                    style: TextStyle(fontSize: 10))
                                            ),
                                          ]
                                      )
                                  )
                                ]
                            )
                        ),
                        Spacer(),
                        _isDeleted ? IconButton(onPressed: () {}, icon: Icon(Icons.close)) : Container()
                      ],
                    ),
                  ),
                ],
              ),
              ListView(
                padding: EdgeInsets.only(top: 10),
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: [
                        Container(
                            child: Row(
                                children:[
                                  Container(
                                    child: const CircleAvatar(
                                      backgroundImage: AssetImage('image/logo.png'),
                                      radius:28,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(left:20),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.chat_bubble,
                                                        color: Colors.black,
                                                        size: 17.0,
                                                      ),
                                                      Container(
                                                          padding: const EdgeInsets.only(left:5),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              child: const Text('[LOL][대전]',
                                                                style: TextStyle(fontSize: 13)
                                                            )
                                                            ),
                                                            Container(
                                                                child: const Text('매칭되었습니다! 당신을 기다려요!',
                                                                    style: TextStyle(fontSize: 13)
                                                                )
                                                            ),
                                                          ],
                                                      )
                                                      )
                                                    ]
                                                )
                                            ),
                                            Container(
                                                child: const Text('#LOL #대전',
                                                    style: TextStyle(fontSize: 10))
                                            ),
                                            Container(
                                                child: const Text('5분전',
                                                    style: TextStyle(fontSize: 10))
                                            ),
                                          ]
                                      )

                                  )
                                ]
                            )

                        ),
                        // SizedBox(width: 32),
                        Spacer(),
                        _isDeleted ? IconButton(
                            padding: new EdgeInsets.only(right:0.0),
                            onPressed: () {}, icon: Icon(Icons.close)) : Container()
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Row(
                      children: [
                        Container(
                            child: Row(
                                children:[
                                  Container(
                                    child: const CircleAvatar(
                                      backgroundImage: AssetImage('image/logo.png'),
                                      radius:28,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(left:20),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.chat_bubble,
                                                        color: Colors.black,
                                                        size: 17.0,
                                                      ),
                                                      Container(
                                                          padding: const EdgeInsets.only(left:5),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                  child: const Text('[LOL][대전]',
                                                                      style: TextStyle(fontSize: 13)
                                                                  )
                                                              ),
                                                              Container(
                                                                  child: const Text('매칭되었습니다! 당신을 기다려요!',
                                                                      style: TextStyle(fontSize: 13)
                                                                  )
                                                              ),
                                                            ],
                                                          )
                                                      )
                                                    ]
                                                )
                                            ),
                                            Container(
                                                child: const Text('#LOL #대전',
                                                    style: TextStyle(fontSize: 10))
                                            ),
                                            Container(
                                                child: const Text('5분전',
                                                    style: TextStyle(fontSize: 10))
                                            ),
                                          ]
                                      )

                                  )
                                ]
                            )

                        ),
                        // SizedBox(width: 32),
                        Spacer(),
                        _isDeleted ? IconButton(
                            padding: new EdgeInsets.only(right:0.0),
                            onPressed: () {}, icon: Icon(Icons.close)) : Container()
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

