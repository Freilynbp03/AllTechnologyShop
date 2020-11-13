import 'dart:async';
import 'package:alltechnologyshop/clients/models/address.dart';
import 'package:alltechnologyshop/clients/models/cart_item.dart';
import 'package:alltechnologyshop/clients/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "users";
  FirebaseAuth _auth;
  void createUser(Map data) {
    _firestore.collection(collection).doc(data["uid"]).set(data);
  }

  Future<UserModel> getUserById(String id)=> _firestore.collection(collection).doc(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });

  void addToCart({String userId, CartItemModel cartItem}){
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }
  void addAddress({String userId, AddressItemModel addressItem}){
    _firestore.collection(collection).doc(userId).update({
      "address": FieldValue.arrayUnion([addressItem.toMap()])
    });
  }

  void removeFromCart({String userId, CartItemModel cartItem}){
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }
  void removeAddress({String userId, AddressItemModel addressItem}){
    _firestore.collection(collection).doc(userId).update({
      "address": FieldValue.arrayRemove([addressItem.toMap()])
    });
  }
  Future<bool> signUp(String name,String email, String password)async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user){
        _firestore.collection('users').doc(user.user.uid).set({
          'name':name,
          'email':email,
          'uid':user.user.uid
        });
      });
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }


}