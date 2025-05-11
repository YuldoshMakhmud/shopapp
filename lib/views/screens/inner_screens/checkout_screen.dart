import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_shop/provider/cart_provider.dart';
import 'package:firebase_shop/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class checkoutScreen extends ConsumerStatefulWidget {
  checkoutScreen({super.key});

  @override
  _checkoutScreenState createState() => _checkoutScreenState();
}

class _checkoutScreenState extends ConsumerState<checkoutScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _selectedPaymentMethod = 'stripe';
  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Checkout',
          style: GoogleFonts.getFont(
            'Lato',
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Your item",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: cartProviderData.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  final cartItem = cartProviderData.values.toList()[index];
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: 336,
                      height: 91,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFEFF0F2)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 6,
                            top: 6,
                            child: SizedBox(
                              width: 311,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 78,
                                    height: 78,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFBCC5FF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.network(
                                      cartItem.imageUrl[0].toString(),
                                    ),
                                  ),
                                  const SizedBox(width: 11),
                                  Expanded(
                                    child: Container(
                                      height: 78,
                                      alignment: const Alignment(0, -0.51),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                cartItem.productName,
                                                style: GoogleFonts.getFont(
                                                  'Lato',
                                                  color: const Color(
                                                    0xFF0B0C1E,
                                                  ),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.3,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                cartItem.categoryName,
                                                style: GoogleFonts.getFont(
                                                  'Lato',
                                                  color: const Color(
                                                    0xFF7F808C,
                                                  ),
                                                  fontSize: 12,
                                                  height: 1.6,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    height: 78,
                                    alignment: const Alignment(0, -0.03),
                                    child: Text(
                                      '\$' +
                                          cartItem.discount.toStringAsFixed(2),
                                      style: GoogleFonts.getFont(
                                        'Lato',
                                        color: const Color(0xFF0B0C1E),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 25),
            Text(
              'Payment Method',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 10),
            RadioListTile<String>(
              title: const Text('Stripe'), // Title bu yerda
              value: 'stripe',
              groupValue: _selectedPaymentMethod,
              onChanged: (String? value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
              activeColor: const Color(0xFF5C69E5),
              fillColor: MaterialStateProperty.resolveWith(
                (states) =>
                    states.contains(MaterialState.selected)
                        ? const Color(0xFF5C69E5)
                        : Colors.grey,
              ),
            ),
            ////Cash on Delivery Section
            RadioListTile<String>(
              title: const Text('Cash on delivery'), // Title bu yerda
              value: 'cashOnDelivery',
              groupValue: _selectedPaymentMethod,
              onChanged: (String? value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
              activeColor: const Color(0xFF5C69E5),
              fillColor: MaterialStateProperty.resolveWith(
                (states) =>
                    states.contains(MaterialState.selected)
                        ? const Color(0xFF5C69E5)
                        : Colors.grey,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            if (_selectedPaymentMethod == 'stripe') {
              // pay with stripe
              setState(() {
                isLoading = true;
              });
            } else {
              for (var item
                  in ref.read(cartProvider.notifier).getCartItems.values) {
                DocumentSnapshot userDoc =
                    await _firestore
                        .collection('buyers')
                        .doc(_auth.currentUser!.uid)
                        .get();
                CollectionReference orderRefer = _firestore.collection(
                  'orders',
                );
                final orderId = const Uuid().v4();
                await orderRefer
                    .doc(orderId)
                    .set({
                      'orderId': orderId,
                      'productName': item.productName,
                      'productId': item.productId,
                      'size': item.productSize,
                      'quantity': item.quantity,
                      'price': item.quantity * item.productPrice,
                      'category': item.categoryName,
                      'productImages': item.imageUrl[0],
                     
                      // 'state':
                      //     (userDoc.data() as Map<String, dynamic>)['state'],
                      'email':
                          (userDoc.data() as Map<String, dynamic>)['email'],
                      // 'locality':
                      //     (userDoc.data() as Map<String, dynamic>)['locality'],
                      'fullName':
                          (userDoc.data() as Map<String, dynamic>)['fullName'],
                      'buyerId': _auth.currentUser!.uid,
                      'deliveredCount': 0,
                      'delivered': false,
                      'processing': true,
                    })
                    .whenComplete(() {
                     
                        cartProviderData.clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MainScreen();
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            margin: const EdgeInsets.all(15),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                            content: Text('order have been placed'),
                          ),
                        );
                        setState(() {
                           isLoading = false;
                        });
                     
                    });
              }
            }
          },
          child: Container(
            width: 338,
            height: 58,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFF3B54EE),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child:
                  isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                        'Pay Now',
                        style: GoogleFonts.getFont(
                          'Lato',
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          height: 1.6,
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
