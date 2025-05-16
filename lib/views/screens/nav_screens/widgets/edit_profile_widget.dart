import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {

Uint8List? _image;

  pickProfileImage(ImageSource source)async{
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if(_file != null){
      return await _file.readAsBytes();
    }else{
      print('no image selected');
    }
  }
  selectGalleryImage()async{
    Uint8List im = await pickProfileImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Profile',style: GoogleFonts.montserrat(
        fontSize: 17,
        fontWeight: FontWeight.bold
      ),),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "full name"
          ),
        ),

        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: 
            TextField(
              decoration: InputDecoration(
                labelText: 'Profile image Url'
              ),
            )),
            IconButton(onPressed: (){
              selectGalleryImage();
            }, icon: Icon(Icons.image))
          ],
        )
      ],
    ),
    actions: [
      TextButton(onPressed: (){
        Navigator.of(context).pop();
      }, child: Text('Cancel')),
      TextButton(onPressed: (){
        
      }, child: Text('Save'))
    ],
    );
    
  }
}