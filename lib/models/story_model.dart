class Story {
  final String id;
  final String author;
  final String image;
  final String story;
  final String title;

  Story({
    required this.id,
    required this.author,
    required this.image,
    required this.story,
    required this.title,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
        id: json['id'] as String,
        author: json['author'] as String,
        image: json['image'] as String,
        story: json['story'] as String,
        title: json['title'] as String);
  }
}
