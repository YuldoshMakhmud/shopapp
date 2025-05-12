import 'package:firebase_shop/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:firebase_shop/views/screens/nav_screens/widgets/gategory_item.dart';
import 'package:firebase_shop/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:firebase_shop/views/screens/nav_screens/widgets/recomended_product_widget.dart';
import 'package:firebase_shop/views/screens/nav_screens/widgets/reuseable_text_widget.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
        child: HeaderWidget(), // header widget
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          //  HeaderWidget(),
            BannerWidget(),
            CategoryItem(),
            ReuseableTextWidget(title: "Recommended For you", subtitle: "View All"),
            RecomendedProductWidget(),
         
          ],
        ),
      ),
    );
  }
}