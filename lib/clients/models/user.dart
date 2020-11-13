import 'package:alltechnologyshop/clients/models/address.dart';
import 'package:alltechnologyshop/clients/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";
  static const ADDRESS ="address";
  static const PROFILE = 'profilePicture';

  String _name;
  String _email;
  String _id;
  String _stripeId;
  int _priceSum = 0;
  String _profile;

//  getters
  String get name => _name;

  String get email => _email;

  String get id => _id;

  String get stripeId => _stripeId;

  String get profile => _profile;

  // public variables
  List<CartItemModel> cart;
  List<AddressItemModel> address;
  int totalCartPrice;



  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _name = data[NAME];
    _email = data[EMAIL];
    _id = data[ID];
    _stripeId = data[STRIPE_ID] ?? "";
    cart = _convertCartItems(data[CART]?? []);
    address = _convertAddressItems(data[ADDRESS]?? []);
    if (data[PROFILE] == null){
     print('No Tiene Imagen');
    }else{
      _profile = data[PROFILE];
    }

    print('Aqui estaaaa');
    totalCartPrice = data[CART] == null ? 0 :getTotalPrice(cart: data[CART]);

  }

  List<CartItemModel> _convertCartItems(List cart){
    List<CartItemModel> convertedCart = [];
    for(Map cartItem in cart){
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
  List<AddressItemModel> _convertAddressItems(List address){
    List<AddressItemModel> convertedCart = [];
    for(Map addressItem in address){
      convertedCart.add(AddressItemModel.fromMap(addressItem));
    }
    return convertedCart;
  }

  int getTotalPrice({List cart}){
    if(cart == null){
      return 0;
    }
    for(Map cartItem in cart){
      _priceSum += cartItem["price"];
    }

    int total = _priceSum;
    return total;
  }
}
