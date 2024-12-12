class Post {
  final int id;
  final String author;
  final String body;
  final String datePosted;

  Post({
    required this.id,
    required this.author,
    required this.body,
    required this.datePosted,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      author: json['author'] ?? 'Unknown Author',
      body: json['body'] ?? 'No content',
      datePosted: json['date_posted'] ?? 'Unknown date',
    );
  }
}
