import 'package:alltechnologyshop/clients/models/product.dart';
import 'package:alltechnologyshop/clients/services/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier{
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsSearched = [];
  List<ProductModel> productsCart = [];


  ProductProvider.initialize(){
    loadProducts();
  }

  loadProducts()async{
    products = await _productServices.getProducts();
    notifyListeners();
  }
  Future ProductsCart({String prodId})async{
    productsCart = await _productServices.getProductsCart();
  }

  Future search({String productName})async{
    productsSearched = await _productServices.searchProducts(productName: productName);
    notifyListeners();
  }

}