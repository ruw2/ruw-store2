class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.tags,
    required this.images,
  });

  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final List<String> tags;
  final List<String> images;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      category: json["category"] ?? "",
      price: json["price"] ?? 0.0,
      rating: json["rating"] ?? 0.0,
      tags: json["tags"] == null ? [] : List<String>.from(json['tags'] as List),
      images:
          json["images"] == null
              ? []
              : List<String>.from((json["images"] as List)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "category": category,
    "price": price,
    "rating": rating,
    "tags": tags,
    "images": images,
  };
}
