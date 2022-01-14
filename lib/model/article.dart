class Article {
  String createrId; // article 작성자 id
  int like;
  List mbti;
  Map post;
  List topic;
  bool createChatOption;
  String createdTime;
  String aid;

  Article({required this.createrId, required this.like, required this.mbti, required this.post, required this.topic, required this.createChatOption, required this.createdTime, required this.aid});

  factory Article.fromDs(dynamic data) {
    return Article(
      createrId: data['createrId'] ?? '',
      like: data['like'] ?? 0,
      mbti: data['mbti'] ?? [],
      post: data['post'] ?? {},
      topic: data['topic'] ?? [],
      createChatOption: data['createChatOption'] ?? true,
      createdTime: data['createdTime'] ?? '',
      aid: data['aid'] ?? '',
    );
  }
}

class ArticleComments {
  String content;
  String userId;
  String time;

  ArticleComments({required this.content, required this.userId, required this.time});

  factory ArticleComments.fromDs(dynamic data) {
    return ArticleComments(
      content: data['content'] ?? '',
      userId: data['userId'] ?? '',
      time: data['time'] ?? '',
    );
  }
}