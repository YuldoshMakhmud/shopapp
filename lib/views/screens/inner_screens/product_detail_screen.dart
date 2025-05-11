import 'package:firebase_shop/provider/cart_provider.dart';
import 'package:firebase_shop/provider/favoritre_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({super.key, required this.productData});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider.notifier);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // automaticallyImplyLeading: false,
        //  iconTheme: IconThemeData(color: Colors.pink),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Product Detail',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: Color(0xFF363330),
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
            IconButton(
              onPressed: () {
                favoriteProviderData.addProuctToFavorite(
                  productName: widget.productData['productName'],
                  productId: widget.productData['productId'],
                  imageUrl: widget.productData['productImages'],
                  productPrice: widget.productData['productPrice'],
                  productSize: widget.productData['productSize'],
                );
                 ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                margin: const EdgeInsets.all(15),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.grey,
                content: Text(widget.productData['productName']),
              ),
            );
              },
              icon:
                  favoriteProviderData.getFavoriteItem.containsKey(
                        widget.productData['productId'],
                      )
                      ? Icon(
                        Icons.favorite,
                        color: Colors.red,

                        // size: 16,
                      )
                      : Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        // size: 16,
                      ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 260,
              height: 274,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 260,
                      height: 260,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8DDFF),
                        borderRadius: BorderRadius.circular(130),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    top: 0,
                    child: Container(
                      width: 216,
                      height: 274,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9CA8FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: SizedBox(
                        height: 300,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.productData['productImages'].length,
                          itemBuilder: ((context, index) {
                            return Image.network(
                              widget.productData['productImages'][index],
                              width: 198,
                              height: 225,
                              fit: BoxFit.cover,
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.productData['productName'],
                    style: GoogleFonts.roboto(
                      color: const Color(0xFF3C55EF),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    " \$${widget.productData['productPrice'].toStringAsFixed(2)}",
                    style: GoogleFonts.roboto(
                      color: const Color(0xFF3C55EF),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.productData['category'],
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Size :',
                    style: GoogleFonts.lato(
                      color: const Color(0xFF343434),
                      fontSize: 16,
                      letterSpacing: 1.6,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['productSize'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: const Color(0xFF126881),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.productData['productSize'][index],
                                  style: GoogleFonts.quicksand(
                                    color: Color(0xFFF6F6F7),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: GoogleFonts.lato(
                      color: const Color(0xFF363330),
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(widget.productData['description']),
                ],
              ),
            ),
          ],
        ),

      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            cartProviderData.addProductToCart(
              productName: widget.productData['productName'],
              productSize: '',
              productPrice: widget.productData['productPrice'],
              catgoryName: widget.productData['category'],
              imageUrl: widget.productData['productImages'],
              instock: widget.productData['quantity'],
              quantity: 1,
              productId: widget.productData['productId'],
              discount: widget.productData['discount'],
              description: widget.productData['description'],
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                margin: const EdgeInsets.all(15),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.grey,
                content: Text(widget.productData['productName']),
              ),
            );
          },
          child: Container(
            width: 386,
            height: 48,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: const Color(0xFF3B54EE),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 148,
                  top: 17,
                  child: Text(
                    'ADD TO CART',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
