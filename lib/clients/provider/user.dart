import 'dart:async';
import 'package:alltechnologyshop/clients/models/address.dart';
import 'package:alltechnologyshop/clients/screens/home.dart';
import 'package:alltechnologyshop/clients/screens/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alltechnologyshop/clients/models/cart_item.dart';
import 'package:alltechnologyshop/clients/models/order.dart';
import 'package:alltechnologyshop/clients/models/product.dart';
import 'package:alltechnologyshop/clients/models/user.dart';
import 'package:alltechnologyshop/clients/services/order.dart';
import 'package:alltechnologyshop/clients/services/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();

  UserModel _userModel;

//  getter
  UserModel get userModel => _userModel;

  Status get status => _status;

  User get user => _user;

  // public variables
  List<OrderModel> orders = [];

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      //_status =Status.Authenticated;
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> signUp(String name,String email, String password)async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user){
        _firestore.collection('users').doc(user.user.uid).set({
          'name':name,
          'email':email,
          'uid':user.user.uid
        });
      });
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }
  Future signOut() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(User user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _userModel = await _userServices.getUserById(user.uid);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<bool> addToCart(
      {ProductModel product, String size, String color}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List<CartItemModel> cart = _userModel.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.picture,
        "productId": product.id,
        "price": product.price,
        "size": size,
        "color": color
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
//      if(!itemExists){
      print("CART ITEMS ARE: ${cart.toString()}");
      _userServices.addToCart(userId: _user.uid, cartItem: item);
//      }

      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }
  Future<bool> addAddress(
      {String name, String country, String province, String municipality, String sector, String street, String apt}) async {
    try {
      var uuid = Uuid();
      String addressItemId = uuid.v4();
      List<AddressItemModel> address = _userModel.address;

      Map addressItem = {
        "id": addressItemId,
        "name": name,
        "country": country,
        "province": province,
        'municipality': municipality,
        'sector': sector,
        'street': street,
        'apt' : apt
      };

      AddressItemModel item = AddressItemModel.fromMap(addressItem);
//      if(!itemExists){
      print("Dirreccion: ${address.toString()}");
      _userServices.addAddress(userId: _user.uid, addressItem: item);
//      }

      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }
  Future<bool> removeFromCart({CartItemModel cartItem})async{
    print("THE PRODUC IS: ${cartItem.toString()}");

    try{
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }

  }
  Future<bool> removeAddress({AddressItemModel addressItem})async{
    print("Dirrecion: ${addressItem.toString()}");

    try{
      _userServices.removeAddress(userId: _user.uid, addressItem: addressItem);
      return true;
    }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }

  }


  getOrders()async{
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<void> reloadUserModel()async{
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }
  Future handleSignIn() async{
    print('Hola 3');
    preferences = await SharedPreferences.getInstance();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
    UserCredential authResult = await firebaseAuth.signInWithCredential(credential);

    final _firebaseUser = authResult.user;
    print('Logeado:' + _firebaseUser.displayName);
    _status = Status.Authenticated;
    if(_firebaseUser != null){
      final QuerySnapshot result = await FirebaseFirestore.instance.collection("users").where("id", isEqualTo: _firebaseUser.uid).get();
      final List<DocumentSnapshot> documents = result.docs;
      if(documents.length == 0) {
        print('prueba3');
        //insertar la coleccion de ussuario
        FirebaseFirestore.instance.collection("users")
            .doc(_firebaseUser.uid)
            .set({
          "id": _firebaseUser.uid,
          "username": _firebaseUser.displayName,
          "profilePicture": _firebaseUser.photoURL
        });
        await preferences.setString("id", _firebaseUser.uid);
        await preferences.setString("username", _firebaseUser.displayName);
        await preferences.setString("profilePicture", _firebaseUser.photoURL);
      }else{
        /*await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("profilePicture", documents[0]['photoUrl']);*/
      }
      Fluttertoast.showToast(msg: "Accedió Exitosamente");
      print('Llegaste Hasta Aqui');

      _Verificar();

    }else{
      Fluttertoast.showToast(msg: "Error al Acceder");
    }
  }

  Future <Login> _Verificar()  async{
        MaterialPageRoute(
            builder: (context) => Login());
  }

}

