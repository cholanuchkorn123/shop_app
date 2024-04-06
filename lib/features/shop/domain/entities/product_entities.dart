class Product {
  int id;
  String name;
  String imageUrl;
  int price;
  bool isSaved;
  int amount;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.isSaved = false,
    this.amount = 0,
  });

  Product copyWith({
    int? id,
    String? name,
    String? imageUrl,
    int? price,
    bool? isSaved,
    int? amount,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      isSaved: isSaved ?? this.isSaved,
      amount: amount ?? this.amount,
    );
  }
}
