import 'package:flutter/material.dart';

class heartTab extends StatelessWidget {
  const heartTab({Key? key}) : super(key: key);

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
                      child:Text("채팅/게시판"),
                    )
                ),Tab(text: "회원"),
              ],
              indicatorColor: Colors.black,
            ),
            automaticallyImplyLeading: true,
            leading: IconButton(icon: const Icon(Icons.arrow_back),
              onPressed: () {  },),
            title: const Text('관심'),
          ),
          body: TabBarView(
            children: [
              GridView.count(
                crossAxisCount: 2,
                children: List.generate(3, (index) {
                  return Center(
                    child: Text(
                      'Item $index',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  );
                }),
              ),
              ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading:
                          const CircleAvatar(
                            backgroundImage: AssetImage('image/logo.png'),
                            radius:25,
                          ),
                      title: const Text('컴공 20'),
                      subtitle: const Text('ENFJ'),
                      trailing: IconButton(
                        icon: const Icon(
                            Icons.favorite,
                            color: Colors.pink,
                            size: 24.0,
                        ), onPressed: () {  },
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading:
                      const CircleAvatar(//이미지 수정 필요
                        backgroundImage: AssetImage('image/logo.png'),
                        radius:25,
                      ),
                      title: const Text('hfhek'),
                      subtitle: const Text('ISFP'),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 24.0,
                        ), onPressed: () {  },
                      ),
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

