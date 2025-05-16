import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shop/views/screens/nav_screens/inner_vendor_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final Stream<QuerySnapshot> vendorsStream = FirebaseFirestore.instance.collection('vendors').snapshots();
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
              image: AssetImage('assets/icons/cartb.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
             
              Positioned(
                left: 61,
                top: 51,
                child: Text(
                  'Stores',
                  style: GoogleFonts.getFont(
                    'Lato',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.7,
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 57,
                child: Image.asset(
                  'assets/icons/arrow.png',
                  width: 10,
                  height: 12,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
      body:  StreamBuilder<QuerySnapshot>(
      stream: vendorsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        }

        return  ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        final vendor = snapshot.data!.docs[index];

                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return InnerVendorProductScreen(vendorid: vendor['uid']);
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  child: Text(vendor['fullName'][0].toUpperCase(),
                                   style: GoogleFonts.montserrat(
                                  
                                  ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(vendor['fullName'],style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                )
                              ],
                            ),
                          ),
                        );
                      }));
      },
    ),
    );
  }
}
