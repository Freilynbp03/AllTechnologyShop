import 'package:alltechnologyshop/clients/helpers/style.dart';
import 'package:alltechnologyshop/clients/models/cart_item.dart';
import 'package:alltechnologyshop/clients/provider/app.dart';
import 'package:alltechnologyshop/clients/provider/user.dart';
import 'package:alltechnologyshop/clients/screens/add_address.dart';
import 'package:alltechnologyshop/clients/services/order.dart';
import 'package:alltechnologyshop/clients/widgets/custom_text.dart';
import 'package:alltechnologyshop/clients/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Dirreciones"),
      ),
      backgroundColor: white,
      body: appProvider.isLoading
          ? Loading()
          : ListView.builder(
          itemCount: userProvider.userModel.address.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: red.withOpacity(0.2),
                          offset: Offset(3, 2),
                          blurRadius: 30)
                    ]),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            softWrap: true,
                            overflow: TextOverflow.clip,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: userProvider
                                      .userModel.address[index].name +
                                      "\n",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: userProvider.userModel.address[index].country + "\n",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300)),
                              TextSpan(
                                  text: userProvider.userModel.address[index].province + "\n",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300)),
                              TextSpan(
                                  text: userProvider.userModel.address[index].municipality + ", ",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300)),
                              TextSpan(
                                  text: userProvider.userModel.address[index].street,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300)),
                            ]),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: red,
                              ),
                              onPressed: () async {
                                appProvider.changeIsLoading();
                                bool success =
                                await userProvider.removeAddress(
                                    addressItem: userProvider
                                        .userModel.address[index]);
                                if (success) {
                                  userProvider.reloadUserModel();
                                  print("Dirreccion Eliminada");
                                  _key.currentState.showSnackBar(SnackBar(
                                      content: Text("Dirreccion Eliminada")));
                                  appProvider.changeIsLoading();
                                  return;
                                } else {
                                  appProvider.changeIsLoading();
                                }
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //Spacer(flex: 1,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: black),
                child: FlatButton(
                    onPressed: () {
                      print('Hola');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAddress()));
                    },
                    child: CustomText(
                      text: "Agregar Direccion",
                      size: 20,
                      color: white,
                      weight: FontWeight.normal,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
