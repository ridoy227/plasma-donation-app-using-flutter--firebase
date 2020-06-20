

import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod{

  FirebaseAuth _auth = FirebaseAuth.instance;

  User _userfromFirebase(FirebaseUser user ){
    return user !=null? User(userId: user.uid): null;
  }

  Future signIn(String email, String password) async {

    try{
      AuthResult result = await _auth.signInWithEmailAndPassword
      (email: email,
       password: password);
       FirebaseUser firebaseUser = result.user;
       return _userfromFirebase(firebaseUser);


    }catch(e){
      print(e.toString());
    }


  }
  Future signUp(String email, String password) async {

    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       FirebaseUser firebaseUser = result.user;
       return _userfromFirebase(firebaseUser);


    }catch(e){
      print(e.toString());
    }


  }
  Future resetPass(String email) async {
    try{
     return _auth.sendPasswordResetEmail(email: email);

    }catch(e){
      print(e.toString()); 
      }

  }
  Future signOut()async{
    try{
    return _auth.signOut();
    }
    catch(e){
      print(e.toString());

    }

  }





}
class User{
  String userId;
  User({this.userId});  
}