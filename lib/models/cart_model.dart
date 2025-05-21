class CartModel {
  final String productName;
  final double productPrice;
  final List<String> imageUrl; 
   int quantity;
  final String productId;
  final String productSize;
  final num discount;
  final String description;
  final String categoryName;
  final int instock;
  final String vendorId;

  CartModel({
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
    required this.quantity,
    required this.productId,
    required this.productSize,
    required this.discount,
    required this.description,
    required this.categoryName,
    required this.instock,
    required this.vendorId,
  });
}