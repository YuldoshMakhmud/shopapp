import 'package:firebase_shop/vendor/controllers/vendor_conroller.dart';
import 'package:firebase_shop/vendor/views/auth/vendor_register_screen.dart';
import 'package:firebase_shop/vendor/views/screens/main_vendor_screen.dart';
import 'package:firebase_shop/views/screens/authentication_screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendorLoginScreen extends StatefulWidget {

  const VendorLoginScreen({super.key});

  @override
  State<VendorLoginScreen> createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VendorAuthController _authController = VendorAuthController();
bool _isLoading = false;
bool _isObscure = true;

  late String email;

  //late String name;

  late String password;
  // loginUser()async{
  //   setState(() {
  //     isLoading = true;
  //   });
  //     await _authController.signInUsers(context: context, email: email, password: password).whenComplete((){
       
  //       setState(() {
  //         isLoading = false;
  //       });
  //     });
  // }
  loginUser()async{
    setState(() {
        _isLoading = true;
      });
    String res = await _authController.loginUser(email, password);
    if(res == "succes"){
    Future.delayed(Duration.zero,(){
          Navigator.push(context, MaterialPageRoute(builder: (context){
          return MainVendorScreen();
    }));});
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("Logged in")));
    }else{
      debugPrint(res);
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login Vendor's Accaunt",
                    style: GoogleFonts.getFont(
                      "Lato",
                      color: Color(0xFF0d120E),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                      fontSize: 23,
                    ),
                  ),
                  Text(
                    "To Explore the world exclusives",
                    style: GoogleFonts.getFont(
                      "Lato",
                      color: Color(0xFF0d120E),
                      letterSpacing: 0.2,
                      fontSize: 14,
                    ),
                  ),
                  Image.asset(
                    'assets/images/Illustration.png',
                    width: 200,
                    height: 200,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Email',
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                     validator: (value) {
                        if(value!.isEmpty){
                          return 'Enter your email';
                        }else{
                          return null;
                        }
                      },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter your email',
                      labelStyle: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontSize: 14,
                        letterSpacing: 0.1
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset('assets/icons/email.png',width: 20,height: 20,),
                      ),
                      
                    ),
                  ),
                  SizedBox(height: 20,),
                   Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Password',
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  TextFormField(
                      obscureText: _isObscure,
                      onChanged: (value) {
                      password = value;
                    },
                     validator: (value) {
                        if(value!.isEmpty){
                          return 'enter your password';
                        }else{
                          return null;
                        }
                      },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter your password',
                      labelStyle: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontSize: 14,
                        letterSpacing: 0.1
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset('assets/icons/password.png',width: 20,height: 20,),
                      ),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          _isObscure =! _isObscure;
                        });
                      }, icon: Icon(_isObscure? Icons.visibility: Icons.visibility_off)),
                      
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                     onTap:()async{
                        if(_formKey.currentState!.validate()){
                       loginUser();
                  
                        }else{
                         debugPrint('feild');
                        }},
                    child: Container(
                      width: 319,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(colors: [
                          Color(0xFF102DE1),
                          Color(0xCC0D6EFF),
                        ])
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 278,
                            top: 19,
                            child: Opacity(opacity: 0.5,
                            child: Container(
                              width: 60,
                              height: 60,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 12,
                                  color: Color(0xFF103DE5)
                                ),
                                borderRadius: BorderRadius.circular(30)
                              ),
                            ),),
                            ),
                            Positioned(left: 311,
                            top: 36,
                            child: Opacity(opacity: 0.3,child: Container(
                              width: 5,
                              height: 5,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3)
                              ),
                            ),),
                            ),
                            Positioned(
                              left: 281,
                              top: -10,
                              child: Opacity(opacity: 0.3,child: Container(
                                width: 20,
                                height: 20,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              ),),
                            ),
                            Center(
                        child:  _isLoading? CircularProgressIndicator(color: Colors.white,):Text('Sign in', style: GoogleFonts.getFont(
                          'Lato',
                          fontSize: 18,
                        fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),
                      ),
                        ],
                      )
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Need an Accaunt?",style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1
                      ),),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> RegisterScreen()));
                        },
                        child: Text("Sign Up",style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF103DE5),
                        ),),
                      )
                    ],
                  ),
SizedBox(height: 10,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Become Vendor?",style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1
                      ),),
                      InkWell(
                        onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder:(context)=> VendorRegisterScreen()));
                        },
                        child: Text("Sign Up",style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF103DE5),
                        ),),
                      )
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}