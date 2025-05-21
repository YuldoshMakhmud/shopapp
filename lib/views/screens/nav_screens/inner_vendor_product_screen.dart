import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Koreyadan/views/screens/nav_screens/widgets/popular_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InnerVendorProductScreen extends StatefulWidget {
  final String vendorid;
  const InnerVendorProductScreen({super.key, required this.vendorid});

  @override
  State<InnerVendorProductScreen> createState() => _InnerVendorProductScreenState();
}

class _InnerVendorProductScreenState extends State<InnerVendorProductScreen> {
  @override
  Widget build(BuildContext context) {
     final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
        .collection('products')
        .where('vendorId', isEqualTo: widget.vendorid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(title: Text('Products',style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),),
      body:  StreamBuilder<QuerySnapshot>(
        stream: _productStream,
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
                'No Product under this vendor\ncheck back later',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.7),
              ),
            );
          }

          return GridView.count(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 300 / 500,
            children: List.generate(
              snapshot.data!.size,
              (index) {
                final productData = snapshot.data!.docs[index];
                return PopularItem(productData: productData);
              },
            ),
          );
        },
      ),
    );
  }
}