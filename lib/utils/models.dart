// Fichier: utils/models.dart
class Dish {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  int likes;
  int dislikes;
  List<Comment> comments;

  Dish({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.likes = 0,
    this.dislikes = 0,
    List<Comment>? comments,
  }) : comments = comments ?? [];
}

class Comment {
  final String author;
  final String text;
  final DateTime date;

  Comment({
    required this.author,
    required this.text,
    required this.date,
  });
}

