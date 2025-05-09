class CartModel {
  final String productName;
  final int productPrice;
  final String categoryName;
  final List imageUrl;
 num quantity;
  final String productId;
  final int instock;
  final String productSize;
  final num discount;
  final String description;

  CartModel(
      {required this.productName,
      required this.instock,
      required this.productPrice,
      required this.categoryName,
      required this.imageUrl,
      required this.quantity,
      required this.productId,
      required this.productSize,
      required this.discount,
      required this.description, });
}