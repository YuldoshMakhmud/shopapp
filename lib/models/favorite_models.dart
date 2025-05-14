class FavoriteModel {
  final String productName;
  final String productId;
  final List imageUrl;

  final double productPrice;

  final List productSize;

  FavoriteModel({
    required this.productName,
    required this.productId,
    required this.imageUrl,
    required this.productPrice,
    required this.productSize,
  });
}