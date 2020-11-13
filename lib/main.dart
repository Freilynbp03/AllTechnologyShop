import 'package:alltechnologyshop/clients/screens/home.dart';
import 'package:alltechnologyshop/clients/screens/login.dart';
import 'package:alltechnologyshop/clients/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alltechnologyshop/clients/provider/user.dart';
import 'package:alltechnologyshop/clients/provider/product.dart';

import 'admin/providers/app_states.dart';
import 'admin/providers/products_provider.dart';
import 'clients/provider/app.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider.value(value: ProductProvider.initialize()),
    ChangeNotifierProvider.value(value: AppProvider()),
    ChangeNotifierProvider.value(value: AppState()),
    ChangeNotifierProvider.value(value: ProductProviderAdmin()),

  ], child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Colors.white
    ),
    home: HomePage(),
  ),));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized:
        return HomePage();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return HomePage();
      case Status.Authenticated:
        return HomePage();
      default: return HomePage();
    }
  }
}




