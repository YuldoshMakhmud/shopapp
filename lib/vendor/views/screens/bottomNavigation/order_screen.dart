import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Koreyadan/vendor/views/screens/inner_screen.dart/vendor_order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorOrderScreen extends StatelessWidget {
  VendorOrderScreen({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.20,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/icons/cartb.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 322,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/icons/not.png',
                      width: 26,
                      height: 25,
                    ),
                    // Positioned(
                    //   top: 0,
                    //   right: 0,
                    //   child: badges.Badge(
                    //     badgeStyle: badges.BadgeStyle(
                    //       badgeColor: Colors.yellow.shade800,
                    //     ),
                    //     badgeContent: Text(
                    //       cartData.length.toString(),
                    //       style: GoogleFonts.lato(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              Positioned(
                left: 61,
                top: 51,
                child: Text(
                  'My Orders',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'You have no Order',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final orderData = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 25,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return VendorOrderDetailScreen(orderData: orderData,);
                    }));
                  },
                  child: Container(
                    width: 335,
                    height: 153,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: SizedBox(
                      width: double.infinity,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 336,
                              height: 154,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(
                                    0xFFEFF0F2,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    left: 13,
                                    top: 9,
                                    child: Container(
                                      width: 78,
                                      height: 78,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFFBCC5FF,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            left: 10,
                                            top: 5,
                                            child: Image.network(
                                              orderData["productImage"],
                                              width: 58,
                                              height: 67,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 101,
                                    top: 14,
                                    child: SizedBox(
                                      width: 216,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      orderData['productName'],
                                                      style:
                                                          GoogleFonts.getFont(
                                                        'Lato',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      orderData['category'],
                                                      style: const TextStyle(
                                                        color: Color(
                                                          0xFF7F808C,
                                                        ),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "\$${orderData['price']}",
                                                    style: const TextStyle(
                                                      color: Color(
                                                        0xFF0B0C1E,
                                                      ),
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 13,
                                    top: 113,
                                    child: Container(
                                      width: 77,
                                      height: 25,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: orderData['delivered'] == true
                                            ? Color(0xFF3C55EF)
                                            : orderData['processing'] == true
                                                ? Colors.purple
                                                : Colors.red,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            left: 9,
                                            top: 3,
                                            child: Text(
                                              orderData['delivered'] == true
                                                  ? 'Delivered'
                                                  : orderData['processing'] ==
                                                          true
                                                      ? "Processing"
                                                      : "Cancelled",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                height: 1.3,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 115,
                                    left: 298,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                              top: 0,
                                              left: 0,
                                              child: InkWell(
                                                onTap: () async {
                                                  await _firestore
                                                      .collection('orders')
                                                      .doc(orderData['orderId'])
                                                      .delete();
                                                },
                                                child: Image.asset(
                                                  'assets/icons/delete.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}