

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_shop/controllers/banner_conroller.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
final BannerController _bannerController =BannerController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 170,
        decoration: BoxDecoration(color: Color(0xFFF7F7F7),boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0,2),
          )
        ]),
         child: StreamBuilder<List<String>>(
          stream: _bannerController.getBannerUrls(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            } else if (snapshot.hasError) {
              print('Error fetching banners: ${snapshot.error}');
              return Icon(Icons.error);
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              print('No banners found.');
              return Center(
                child: Text(
                  'No banners available',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              );
            
            }else{
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
      PageView.builder(
        itemCount:  snapshot.data!.length,
        itemBuilder: (context,index){
      return CachedNetworkImage(
        imageUrl:snapshot.data![index],
        fit: BoxFit.cover,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
     );
        }),
        _buildPageIndicator(snapshot.data!.length)
        ],
      );
            }
          }
      )
      ),
    );
  }
  Widget _buildPageIndicator(int pageCount) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageCount, (index) {
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue, // Indicator color
            ),
          );
        }),
      ),
    );
  }
}
