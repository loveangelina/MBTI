class Article {
  String createrId; // article 작성자 id
  int like;
  List mbti;
  Map<String, String> post;
  List topic;

  Article({required this.createrId, required this.like, required this.mbti, required this.post, required this.topic});

  factory Article.fromDs(dynamic data) {
    return Article(
        createrId: data['createrId'] ?? '',
        like: data['like'] ?? 0,
        mbti: data['mbti'] ?? [],
        post: data['post'] ?? {},
        topic: data['topic'] ?? []
    );
  }
}

class ArticleComments {
  String contents;
  String userId;

  ArticleComments(this.contents, this.userId);


}