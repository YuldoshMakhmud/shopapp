import 'package:firebase_shop/vendor/views/screens/bottomNavigation/earning_screen.dart';
import 'package:firebase_shop/vendor/views/screens/bottomNavigation/edit_product.dart';
import 'package:firebase_shop/vendor/views/screens/bottomNavigation/upload_product_vendor_screen.dart';
import 'package:firebase_shop/vendor/views/screens/bottomNavigation/vendor_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  List<Widget> _pages = [
EarningScreen(),
UploadProductVendorScreen(),
EditProduct(),
VendorProfile(),
  ];
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        currentIndex: pageIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white.withOpacity(0.95),
            icon: Icon(CupertinoIcons.money_dollar),
            label: 'Earning',
          ),
          
         
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.upload_circle),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: _pages[pageIndex],
    );
  }
}