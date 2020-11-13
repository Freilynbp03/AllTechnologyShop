import 'package:alltechnologyshop/clients/screens/address.dart';
import 'package:alltechnologyshop/clients/screens/order.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'access.dart';

enum Page { dashboard, manage }

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Page _selectedPage = Page.manage;
  Color active = Colors.black;
  MaterialColor notActive = Colors.grey;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    setState(() => _selectedPage = Page.dashboard);
                  },
                  icon: Icon(
                    Icons.insert_chart,
                    color: _selectedPage == Page.dashboard
                        ? active
                        : notActive,
                  ),
                  label: Text('Estadisticas')),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                        _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Administrar'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed:(){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrdersScreen()));
                              },
                              icon: Icon(Icons.shopping_basket),
                              label: Text("Ordenes")),
                          subtitle: Text(
                            '7',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.shopping_cart),
                              label: Text("Compras")),
                          subtitle: Text(
                            '23',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.favorite),
                              label: Text("Deseo")),
                          subtitle: Text(
                            '12',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.mood_bad),
                              label: Text("Devoluciones")),
                          subtitle: Text(
                            '0',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Ordenes',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text("Tus Ordenes"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrdersScreen()));
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Ajustes de la Cuenta',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Acceso Y Seguridad"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Access()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.room),
              title: Text("Dirrecciones"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Address()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Actualizar Perfil"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Formas de Pago',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text("Formas de Pago"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text("Bonos"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }
}