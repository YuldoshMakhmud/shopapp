import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_shop/views/screens/inner_screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ProductItemWidget extends StatelessWidget {
  final dynamic productData;

  const ProductItemWidget({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(
            productData: productData,
          );
        }));
      },
      child: Container(
        width: 146,
        height: 245,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 146,
                height: 245,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0f040828),
                        spreadRadius: 0,
                        offset: Offset(
                          0,
                          18,
                        ),
                        blurRadius: 30,
                      ),
                    ]),
              ),
            ),
            Positioned(
              left: 7,
              top: 130,
              child: Text(
                productData['productName'],
                style: GoogleFonts.lato(
                  color: const Color(
                    0xFF1E3354,
                  ),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Positioned(
              left: 7,
              top: 177,
              child: Text(
                productData['category'],
                style: GoogleFonts.lato(
                  color: Color(0xFF7F8E9D),
                  fontSize: 12,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            Positioned(
              left: 7,
              top: 207,
              child: Text(
                '\$${productData['discount']}',
                style: GoogleFonts.lato(
                  color: const Color(0xFF1E3354),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
            ),
            Positioned(
              left: 51,
              top: 210,
              child: Text(
                "\$${productData['productPrice']}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
            Positioned(
              left: 9,
              top: 9,
              child: Container(
                width: 128,
                height: 108,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    3,
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: -1,
                      top: -1,
                      child: Container(
                        width: 130,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Color(
                            0xFFFFF5C3,
                          ),
                          border: Border.all(
                            width: 0.8,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 14,
                      top: 4,
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          width: 100,
                          height: 100,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFFFF44F,
                            ),
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: -10,
                      child: CachedNetworkImage(
                        imageUrl: productData['productImage'][0],
                        width: 108,
                        height: 107,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 56,
              top: 155,
              child:  Text(
                  '${productData['quantity']} ta qoldi',
                  style: TextStyle(
                    color: Color(0xFF7F8E9D),
                    fontSize: 12,
                    fontFamily: 'Lato',
                  ),
                ),
            ),
            Positioned(
              left: 23,
              top: 155,
              child: Text(
                productData['rating'] == 0
                    ? ""
                    : productData['rating'].toString(),
                style: GoogleFonts.lato(
                  color: const Color(
                    0xFF7F8E9D,
                  ),
                  fontSize: 12,
                ),
              ),
            ),
            productData['rating'] == 0
                ? const SizedBox()
                : const Positioned(
                    left: 8,
                    top: 158,
                    child: Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 12,
                    ),
                  ),
            Positioned(
              left: 104,
              top: 15,
              child: Container(
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                    color: const Color(0xFFFA634D),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33FF2000),
                        spreadRadius: 0,
                        offset: Offset(0, 7),
                        blurRadius: 15,
                      )
                    ]),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}