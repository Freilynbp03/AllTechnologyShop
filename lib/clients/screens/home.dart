import 'package:alltechnologyshop/admin/screens/admin.dart';
import 'package:alltechnologyshop/admin/screens/dashboard.dart';
import 'package:alltechnologyshop/clients/helpers/common.dart';
import 'package:alltechnologyshop/clients/helpers/style.dart';
import 'package:alltechnologyshop/clients/provider/product.dart';
import 'package:alltechnologyshop/clients/provider/user.dart';
import 'package:alltechnologyshop/clients/screens/address.dart';
import 'package:alltechnologyshop/clients/screens/login.dart';
import 'package:alltechnologyshop/clients/screens/account.dart';
import 'package:alltechnologyshop/clients/screens/product_search.dart';
import 'package:alltechnologyshop/clients/services/product.dart';
import 'package:alltechnologyshop/clients/widgets/custom_text.dart';
import 'package:alltechnologyshop/clients/widgets/featured_products.dart';
import 'package:alltechnologyshop/clients/widgets/product_card.dart';
import 'package:alltechnologyshop/clients/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import 'add_address.dart';
import 'cart.dart';
import 'order.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<ScaffoldState>();
  ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: white,
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: new CircleAvatar(
                radius: 50.0,
                backgroundColor: const Color(0xFF778899),
                backgroundImage:
                NetworkImage(userProvider.userModel?.profile ?? "https://cdn0.iconfinder.com/data/icons/social-media-network-4/48/male_avatar-512.png"),
              ),
              decoration: BoxDecoration(color: black),
              accountName: CustomText(
                text: userProvider.userModel?.name ?? "username lading...",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: userProvider.userModel?.email ?? "email loading...",
                color: white,
              ),
            ),
            ListTile(
              onTap: () async{
                await userProvider.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.shopping_basket),
              title: CustomText(text: "Mis Ordenes"),
            ),
            ListTile(
              onTap: () async{
              },
              leading: Icon(Icons.favorite),
              title: CustomText(text: "Lista de Deseos"),
            ),
           ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Dashboard()));

              },
              leading: Icon(Icons.dashboard),
              title: CustomText(text: "Administrar"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Account()));

              },
              leading: Icon(Icons.person),
              title: CustomText(text: "Mi Cuenta"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Address()));

              },
              leading: Icon(Icons.room),
              title: CustomText(text: "Dirreciones"),
            ),
            ListTile(
              onTap: () {

                userProvider.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Login()));

              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Salir"),
            ),
            ListTile(
              onTap: () {

              },
              leading: Icon(Icons.settings),
              title: CustomText(text: "Ajustes"),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
//           Custom App bar
            Stack(
              children: <Widget>[
                Positioned(
                  top: 10,
                  right: 20,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () {
                            _key.currentState.openEndDrawer();
                          },
                          child: Icon(Icons.menu))),
                ),
                Positioned(
                  top: 10,
                  right: 60,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: (){
                            changeScreen(context, CartScreen());
                          },
                          child: Icon(Icons.shopping_cart))),
                ),
                Positioned(
                  top: 10,
                  right: 100,
                  child: Align(
                      alignment: Alignment.topRight, child: GestureDetector(
                      onTap: (){
                        _key.currentState.showSnackBar(SnackBar(
                            content: Text("Perfil")));
                      },
                      child: Icon(Icons.person))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Que te gustaria\ncomprar?',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),

//          Search Text field
//            Search(),

            Container(
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 8, right: 8, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: black,
                    ),
                    title: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern)async{
                        await productProvider.search(productName: pattern);
                        changeScreen(context, ProductSearchScreen());
                      },
                      decoration: InputDecoration(
                        hintText: "Ej: Audifanos Gaming",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

//            featured products
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Productos Destacados')),
                ),
              ],
            ),
            FeaturedProducts(),

//          recent products
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Poductos Recientes')),
                ),
              ],
            ),

            Column(
              children: productProvider.products
                  .map((item) => GestureDetector(
                        child: ProductCard(
                          product: item,
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
//Row(
//mainAxisAlignment: MainAxisAlignment.end,
//children: <Widget>[
//GestureDetector(
//onTap: (){
//key.currentState.openDrawer();
//},
//child: Icon(Icons.menu))
//],
//),
