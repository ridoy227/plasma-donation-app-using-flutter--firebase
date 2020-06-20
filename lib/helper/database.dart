import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod{

  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('name', isEqualTo: searchField)
        .getDocuments();
  }
  getByEmail(String userEmail) {
    return Firestore.instance
        .collection("users")
        .where('Email', isEqualTo: userEmail)
        .getDocuments();
        
  }
  uploadUserInfo(userMap, uid){
    Firestore.instance.collection("users").document(uid).setData(userMap).catchError((e){
      print(e.toString());
    });

  }
  uploadUserWhitelistInfo(userMap, uid, name){
    Firestore.instance.collection("users").document(uid).collection("Whitelist").document(name).setData(userMap).catchError((e){
      print(e.toString());
    });

  }
  createChatRoom(String chatRoomId, chatRoomMap){
    Firestore.instance.collection("ChatRoom").document(chatRoomId).setData(chatRoomMap).catchError((e)
    {
      print(e.toString());
    }
    
    );

  }


}