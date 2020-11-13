import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alltechnologyshop/admin/db/product.dart';
import 'package:provider/provider.dart';
import 'package:alltechnologyshop/admin/providers/products_provider.dart';
import '../db/category.dart';
import '../db/brand.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService productService = ProductService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quatityController = TextEditingController();
  final priceController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  List<String> selectedSizes = <String>[];
  List<String> colors = <String>[];
  bool onSale = false;
  bool featured = false;

  File _image1;
  bool isLoading = false;

  @override
  void initState() {
    _getCategories();
    _getBrands();
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i].data()['category']),
                value: categories[i].data()['category']));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandosDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(brands[i].data()['brand']),
                value: brands[i].data()['brand']));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProviderAdmin>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: GestureDetector(
          child: Icon(
            Icons.close,
            color: black,
          ),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Añadir Producto",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              child: OutlineButton(
                                  borderSide: BorderSide(
                                      color: grey.withOpacity(0.5), width: 2.5),
                                  onPressed: () {
                                    _selectImage(
                                        ImagePicker.pickImage(
                                            source: ImageSource.gallery),
                                        );
                                  },
                                  child: _displayChild1()),
                            ),
                          ),
                        ),

                      ],
                    ),

                    Text('Elegir Color'),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              if(productProvider.selectedColors.contains('Rojo')){
                                productProvider.removeColor('Rojo');
                              }else{
                                productProvider.addColors('Rojo');

                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(width: 24, height: 24, decoration: BoxDecoration(
                                color: productProvider.selectedColors.contains('Rojo') ? Colors.blue : grey,
                                borderRadius: BorderRadius.circular(15)
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                ),
                              ),),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              if(productProvider.selectedColors.contains('Amarrillo')){
                                productProvider.removeColor('Amarrillo');
                              }else{
                                productProvider.addColors('Amarrillo');

                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(width: 24, height: 24, decoration: BoxDecoration(
                                color: productProvider.selectedColors.contains('Amarrillo') ? red : grey,
                                borderRadius: BorderRadius.circular(15)
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.yellow,
                                ),
                              ),),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              if(productProvider.selectedColors.contains('Azul')){
                                productProvider.removeColor('Azul');
                              }else{
                                productProvider.addColors('Azul');

                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(width: 24, height: 24, decoration: BoxDecoration(
                                color: productProvider.selectedColors.contains('Azul') ? red : grey,
                                borderRadius: BorderRadius.circular(15)
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                ),
                              ),),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              if(productProvider.selectedColors.contains('Verde')){
                                productProvider.removeColor('Verde');
                              }else{
                                productProvider.addColors('Verde');

                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(width: 24, height: 24, decoration: BoxDecoration(
                                color: productProvider.selectedColors.contains('Verde') ? red : grey,
                                borderRadius: BorderRadius.circular(15)
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                ),
                              ),),
                          ),
                        ),




                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              if(productProvider.selectedColors.contains('Blanco')){
                                productProvider.removeColor('Blanco');
                              }else{
                                productProvider.addColors('Blanco');

                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(width: 24, height: 24, decoration: BoxDecoration(
                                color: productProvider.selectedColors.contains('Blanco') ? red : grey,
                                borderRadius: BorderRadius.circular(15)
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: white,
                                ),
                              ),),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              if(productProvider.selectedColors.contains('Negro')){
                                productProvider.removeColor('Negro');
                              }else{
                                productProvider.addColors('Negro');

                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(width: 24, height: 24, decoration: BoxDecoration(
                                color: productProvider.selectedColors.contains('Negro') ? red : grey,
                                borderRadius: BorderRadius.circular(15)
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: black,
                                ),
                              ),),
                          ),
                        ),
                      ],
                    ),

                    Text('Elegir Condicion'),

                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: selectedSizes.contains('Nuevo'),
                            onChanged: (value) => changeSelectedSize('Nuevo')),
                        Text('Nuevo'),
                        Checkbox(
                            value: selectedSizes.contains('Usado'),
                            onChanged: (value) => changeSelectedSize('Usado')),
                        Text('Usado'),
                        Checkbox(
                            value: selectedSizes.contains('Usado como Nuevo'),
                            onChanged: (value) => changeSelectedSize('Usado como Nuevo')),
                        Text('Usado como Nuevo'),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Oferta'),
                            SizedBox(width: 10,),
                            Switch(value: onSale, onChanged: (value){
                              setState(() {
                                onSale = value;
                              });
                            }),
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            Text('Destacados'),
                            SizedBox(width: 10,),
                            Switch(value: featured, onChanged: (value){
                              setState(() {
                                featured = value;
                              });
                            }),
                          ],
                        ),

                      ],
                    ),




                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: productNameController,
                        decoration: InputDecoration(hintText: 'Nombre del Producto'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Llenar Campo Producto';
                          } else if (value.length > 40) {
                            return 'Maximo 40 caracteres';
                          }
                        },
                      ),
                    ),

//              select category
                    Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Categoria: ',
                                style: TextStyle(color: Colors.blue, fontSize: 17),
                              ),
                            ),
                            DropdownButton(
                              items: categoriesDropDown,
                              onChanged: changeSelectedCategory,
                              value: _currentCategory,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                            'Marca: ',
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                        ),
                          ), DropdownButton(
                          items: brandsDropDown,
                          onChanged: changeSelectedBrand,
                          value: _currentBrand,
                          ),
                          ],
                        ),
                      ],
                    ),

//
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: quatityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Cantidad',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Llenar campo cantidad';
                          }
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Precio',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Llenar campo precio';
                          }
                        },
                      ),
                    ),





                    FlatButton(
                      color: Colors.blue,
                      textColor: white,
                      child: Text('Añadir Producto'),
                      onPressed: () {
                        validateAndUpload();
                      },
                    )
                  ],
                ),
        ),
      ),
    );
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropdown();
      _currentCategory = categories[0].data()['category'];
    });
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    print(data.length);
    setState(() {
      brands = data;
      brandsDropDown = getBrandosDropDown();
      _currentBrand = brands[0].data()['brand'];
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentCategory = selectedBrand);
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }

  void _selectImage(Future<File> pickImage) async {
    File tempImg = await pickImage;
    setState(() => _image1 = tempImg);
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }



  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (_image1 != null) {
        if (selectedSizes.isNotEmpty) {
          String imageUrl1;

          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task1 =
              storage.ref().child(picture1).putFile(_image1);

          StorageTaskSnapshot snapshot1 =
              await task1.onComplete.then((snapshot) => snapshot);


          task1.onComplete.then((snapshot3) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();

            productService.uploadProduct({
              "name":productNameController.text,
              "price":double.parse(priceController.text),
              "condition":selectedSizes,
              "colors": colors,
              "picture":imageUrl1,
              "quantity":int.parse(quatityController.text),
              "brand":_currentBrand,
              "category":_currentCategory,
              'sale':onSale,
              'featured':featured
            });
            _formKey.currentState.reset();
            setState(() => isLoading = false);
            Navigator.pop(context);
          });
        } else {
          setState(() => isLoading = false);
        }
      } else {
        setState(() => isLoading = false);

//        Fluttertoast.showToast(msg: 'all the images must be provided');
      }
    }
  }
}
