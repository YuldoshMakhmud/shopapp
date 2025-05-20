import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String>registerNewUser(
    String email,String name, String password
  )async{
    String res = 'somethind went wrong';
    try{
    // we went create the user first in the authticaton tab abd theb in the cloud firestroe

  UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

  await _firestore.collection('buyers').doc(userCredential.user!.uid).set({
        'fullName': name,
        'profileImage': '',
        'email': email,
        'uid': userCredential.user!.uid,
        'pinCode ': "",
        'locality': "",
        'city': '',
        'state': '',
      });

  res = 'success';
    } on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    res =('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    'The account already exists for that email.';
  }

    }
    
    // ignore: empty_catches
    catch(e){}

    return res;
  }

  //login user
  Future<String> loginUser(String email, String password) async {
  String res = 'something is wrong';

  try {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

   res = "succes";
  } on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    res ='No user found for that email.';
  } else if (e.code == 'wrong-password') {
   res = 'Wrong password provided for that user.';
  }
  }
   catch (e) {
    res= e.toString();
  }

  return res;
}

}