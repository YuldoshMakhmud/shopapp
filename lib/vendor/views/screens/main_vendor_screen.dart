import 'package:Koreyadan/vendor/views/screens/bottomNavigation/earning_screen.dart';
import 'package:Koreyadan/vendor/views/screens/bottomNavigation/edit_product.dart';
import 'package:Koreyadan/vendor/views/screens/bottomNavigation/order_screen.dart';
import 'package:Koreyadan/vendor/views/screens/bottomNavigation/upload_product_vendor_screen.dart';
import 'package:Koreyadan/vendor/views/screens/bottomNavigation/vendor_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
 final List<Widget> _pages = [
EarningScreen(),
UploadProductVendorScreen(),
VendorOrderScreen(),
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
            backgroundColor: Colors.white,
            icon: Icon(CupertinoIcons.money_dollar),
            label: 'Earning',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.upload_circle),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'Order',
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