import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadProductVendorScreen extends StatefulWidget {
 UploadProductVendorScreen({super.key});

  @override
  State<UploadProductVendorScreen> createState() => _UploadProductVendorScreenState();
}

class _UploadProductVendorScreenState extends State<UploadProductVendorScreen> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _sizeController = TextEditingController();
    final ImagePicker picker = ImagePicker();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  bool _isLoading = false;
  final List<String> _sizeList = [];
  final List<String> _categoryList = [];
  final List<String> _imagesUrlList = [];

  String? selectedCategory;
  String? productName;
  double? productPrice;
  int? discount;
  int? quantity;
  String? description;

  bool _isEntered = false;

  List<File> images = [];
  chooseImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile == null){
      print('no image picked');
    }else{
      setState((){
        images.add(File(pickedFile.path));
      });
    }
  }
  //fetch categories from cloud firebase
    _getCategories() {
    return _firestore.collection('categories').get().then((
      QuerySnapshot querySnapshot,
    ) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      }
    });
  }
  // upload images storage
   uploadProductImages() async {
    for (var img in images) {
      Reference ref = _firebaseStorage.ref().child('productImages').child(Uuid().v4());

      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          setState(() {
            _imagesUrlList.add(value);
          });
        });
      });
    }
    print(_imagesUrlList);
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

uploadData()async{
  setState(() {
    _isLoading =true;
  });
  DocumentSnapshot vendorDoc = await _firestore.collection('vendors').doc(FirebaseAuth.instance.currentUser!.uid).get();
  await uploadProductImages();
  if(_imagesUrlList.isNotEmpty){
    final productId = Uuid().v4();
    await _firestore.collection('products').doc(productId).set({
  'productId': productId,
        'category': selectedCategory,
        'productSize': _sizeList,
        'productName': productName,
        'productPrice': productPrice,
        'discount': discount,
        'description': description,
        'productImage': _imagesUrlList,
        'quantity': quantity,
        'vendorId': FirebaseAuth.instance.currentUser!.uid,
        'vendorName': (vendorDoc.data() as Map<String, dynamic>)['fullName'],
        'rating': 0,
        'totalReviews':0,
        'isPopular': false,
  
    }).whenComplete((){
      setState(() {
          _formKey.currentState!.reset();
        _imagesUrlList.clear();
        images.clear();
        _isLoading =false;
      });
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: images.length +1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 4,
            childAspectRatio: 1
            ), 
            itemBuilder: (context, index){
              return index==0? Center(child: IconButton(onPressed: (){
                chooseImage();
              }, icon: const Icon(Icons.add)),): SizedBox(
                child: Image.file(images[index-1]),
              );
            }),
            SizedBox(height: 10,),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children:[TextFormField(
                  onChanged: (value) {
                    productName = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter feild';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Product Name',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                               ),
                               ]
               ),
             ),
              SizedBox(height: 20),
            Row(
              children: [
                Flexible(child: buildDropDownField()),
                SizedBox(width: 20),
                Flexible(
                  child: TextFormField(
                    onChanged: (value) {
                     if(value.isNotEmpty && double.tryParse(value) != null){
                       productPrice = double.parse(value);
                     }else{
                      // handle the case where value is invalid or empty
                      productPrice = 0.0;
                     }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter feild';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Price',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
             TextFormField(
              onChanged: (value) {
                 if(value.isNotEmpty && int.tryParse(value) != null){
                       discount= int.parse(value);
                     }else{
                      // handle the case where value is invalid or empty
                      discount = 0;
                     }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter feild';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: 'Discount price',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              onChanged: (value) {
                if(value.isNotEmpty && int.tryParse(value) != null){
                       quantity = int.parse(value);
                     }else{
                      // handle the case where value is invalid or empty
                      quantity = 0;
                     }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter feild';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: 'Quantity',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
             TextFormField(
              onChanged: (value) {
                description = value;
              },
              maxLength: 800,
              maxLines: 4,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter feild';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: 'Description',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: _sizeController,
                      onChanged: (value) {
                        setState(() {
                          _isEntered = true;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Add Size',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                _isEntered == true
                    ? Flexible(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _sizeList.add(_sizeController.text);
                            _sizeController.clear();
                          });
                        },
                        child: const Text('Add'),
                      ),
                    )
                    : const Text(''),
              ],
            ),
            _sizeList.isNotEmpty
                ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _sizeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _sizeList.removeAt(index);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade800,
                              borderRadius: BorderRadius.circular(8),
                            ),
      
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _sizeList[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
                : Text(''),
               InkWell(
                onTap: (){
                 if(_formKey.currentState!.validate()){
                  uploadData();
                 }
                },
                 child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF103DE5),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: _isLoading?CircularProgressIndicator(color: Colors.white,): Center(
                      child: Text(
                        'UPLOAD PRODUCT',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
               ),
        ],

      ),
    )
    );
  }
    Widget buildDropDownField() {
    return DropdownButtonFormField(
      onChanged: (String? value) {
        if (value != null) {
          setState(() {
            selectedCategory = value;
          });
        }
      },
      items:
          _categoryList.map((value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
      decoration: InputDecoration(
        labelText: 'Select category',
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      ),
    );
  }
}