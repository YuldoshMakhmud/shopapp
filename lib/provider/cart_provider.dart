import 'package:firebase_shop/models/cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<String, CartModel>>(
        (ref) => CartNotifier());

class CartNotifier extends StateNotifier<Map<String, CartModel>> {
  CartNotifier() : super({});

  void addProductToCart({
    required String productName,
    required int productPrice,
    required String catgoryName,
    required List imageUrl,
    required int quantity,
    required String productId,
    required String productSize,
    required num discount,
    required String description,
    required int instock,
  }) {
    if (state.containsKey(productId)) {
      state = {
        ...state,
        productId: CartModel(
          productId: state[productId]!.productId,
          categoryName: state[productId]!.categoryName,
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice,
          quantity: state[productId]!.quantity + 1,
          imageUrl: state[productId]!.imageUrl,
          productSize: state[productId]!.productSize,
          discount: state[productId]!.discount,
          description: state[productId]!.description, 
          instock: state[productId]!.instock,
        )
      };
    } else {
      state = {
        ...state,
        productId: CartModel(
          productName: productName,
          productPrice: productPrice,
          imageUrl: imageUrl,
          quantity: quantity,
          productId: productId,
          productSize: productSize,
          discount: discount,
          description: description,
           categoryName: catgoryName,
           instock: instock
        
        )
      };
    }
  }

void decrementItem(String productId) {
  if (state.containsKey(productId)) {
    if (state[productId]!.quantity > 1) {
      // Agar miqdor 1 dan katta bo'lsa, kamaytiramiz
      state[productId]!.quantity--;
      state = {...state}; // State yangilash
    } else {
      // Agar miqdor 1 bo'lsa (kamaytirgandan keyin 0 bo'ladi), o'chiramiz
      removeItem(productId);
    }
  }
}

  void removeItem(String productId) {
    state.remove(productId);

    state = {...state};
  }

  void incrementItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;

      ///notify listeners that the state has changed
      ///
      state = {...state};
    }
  }

  double calculateTotalAmount() {
    double totalAmount = 0.0;
    state.forEach((productId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });

    return totalAmount;
  }

   Map<String, CartModel> get getCartItems => state;
}