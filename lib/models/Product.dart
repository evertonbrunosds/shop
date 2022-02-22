class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool _isFavorite = false;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    bool isFavorite = false,
  }) {
    _isFavorite = isFavorite;
  }

  void toogleFavorite() => _isFavorite = !_isFavorite;

  bool get isFavorite => _isFavorite;

}
