import 'package:alltechnologyshop/clients/helpers/common.dart';
import 'package:alltechnologyshop/clients/helpers/style.dart';
import 'package:alltechnologyshop/clients/provider/user.dart';
import 'package:alltechnologyshop/clients/widgets/custom_text.dart';
import 'package:alltechnologyshop/clients/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'package:alltechnologyshop/clients/provider/app.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
class AddAddress extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  List _items_province = [
    {
      'display':'Azúa',
      'value': 'Azua'
      },
      {
        'display':'Baoruco',
        'value':'Baoruco'
      },
      {'display':'Barahona',
        'value':'Barahona'} ,
      {'display':'Dajabón',
        'value':'Dajabón'},
      {'display':'Distrito Nacional',
        'value':'Distrito Nacional'},
      {'display':'Duarte',
        'value':'Duarte'},
      {'display':'Elías Pina',
        'value':'Elías Pina'},
      {'display':'El Seibo',
        'value':'El Seibo'},
      {'display':'Espaillat',
        'value':'Espaillat'},
      {'display':'Hato Mayor',
        'value':'Hato Mayor'},
      {'display':'Independencia',
        'value':'Independencia'},
      {'display':'La Altagracia',
        'value':'La Altagracia'},
      {'display':'La Romana',
        'value':'La Romana'},
      {'display': 'La Vega',
        'value': 'La Vega'},
      {'display':'Maria Trinidad Sanchez',
        'value':'Maria Trinidad Sanchez'},
      {'display':'Monseñor Nouel',
        'value':'Monseñor Nouel'},
      {'display':'Monte Cristi',
        'value':'Monte Cristi'},
      {'display':'Monte Plata',
        'value':'Monte Plata'},
      {'display':'Pedernales',
        'value':'Pedernales'},
      {'display':'Peravia',
        'value':'Peravia'},
      {'display':'Puerto Plata',
        'value':'Puerto Plata'},
      {'display':'Salcedo',
        'value':'Salcedo'},
      {'display':'Samana',
        'value':'Samana'},
      {'display':'Sánchez Ramírez',
        'value':'Sánchez Ramírez'},
      {'display':'San Cristobal',
        'value':'San Cristobal'},
      {'display':'San Jose de Ocoa',
        'value':'San Jose de Ocoa'},
      {'display':'San Juan',
        'value':'San Juan'},
      {'display':'San Pedro de Macorís',
        'value':'San Pedro de Macorís'},
      {'display':'Santiago',
        'value':'Santiago'},
      {'display':'Santiago Rodríguez',
        'value':'Santiago Rodríguez'},
      {'display':'Santo Domingo',
        'value':'Santo Domingo'} ,
      {'display':'Valverde',
        'value':'Valverde'},
    ];

  TextEditingController _name = TextEditingController();
  TextEditingController _municipality = TextEditingController();
  TextEditingController _sector = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _apt = TextEditingController();
  bool hidePass = true;
  String _country;
  String _countryResult;
  String _province;
  String _provinceResult;
  @override
  void initState() {
    super.initState();
    _country = '';
    _countryResult ='';
    _province = '';
    _provinceResult = '';
  }

  _saveForm() {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _provinceResult = _province;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Añadir Dirreccion'),
      ),
      body: Stack(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[350],
                    blurRadius:
                    20.0, // has the effect of softening the shadow
                  )
                ],
              ),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.3),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _name,
                                decoration: InputDecoration(
                                    hintText: "Nombre Completo",
                                    icon: Icon(Icons.room_outlined),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Campo obligatorio";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: DropDownFormField(
                          titleText: 'Pais',
                          hintText: 'Elegir Pais',
                          value: _country,
                          onSaved: (value) {
                            setState(() {
                              _country = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _country = value;
                            });
                          },
                          dataSource: [{
                            'display': 'Republica Dominica',
                            'value': 'Republica Dominica'
                          }],
                          textField: 'display',
                          valueField: 'value',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: DropDownFormField(
                          titleText: 'Provincia',
                          hintText: 'Elegir Provincia',
                          value: _province,
                          onSaved: (value) {
                            setState(() {
                              _province = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _province = value;
                            });
                          },
                          dataSource: _items_province,
                          textField: 'display',
                          valueField: 'value',
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.3),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _municipality,
                                decoration: InputDecoration(
                                    hintText: "Municipio",
                                    icon: Icon(Icons.room_outlined),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Campo obligatorio";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.3),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _sector,
                                decoration: InputDecoration(
                                    hintText: "Sector",
                                    icon: Icon(Icons.room),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Campo obligatorio";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.3),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _street,
                                decoration: InputDecoration(
                                    hintText: "Carretera",
                                    icon: Icon(Icons.room_outlined),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Campo obligatorio";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.3),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _apt,
                                decoration: InputDecoration(
                                    hintText: "Apt/Casa(Opcional)",
                                    icon: Icon(Icons.home),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.black,
                            elevation: 0.0,
                            child: MaterialButton(
                              onPressed: () async{
                                setState(() {
                                  _countryResult = _country;
                                  _provinceResult = _province;
                                });
                                print('Pais'+ _country + 'Aqui');
                                print('Provincia'+ _province + 'Aqui');
                                print('Municipio' + _municipality.text);
                                appProvider.changeIsLoading();
                                bool success = await userProvider.addAddress(
                                    country: _country,
                                    name: _name.text,
                                    province: _province,
                                    municipality: _municipality.text,
                                    sector: _sector.text,
                                    street: _street.text,
                                    apt: _apt.text);
                                if (success) {
                                  _key.currentState.showSnackBar(
                                      SnackBar(content: Text("Direccion Añadido")));
                                  userProvider.reloadUserModel();
                                  appProvider.changeIsLoading();
                                  return;
                                } else {
                                  _key.currentState.showSnackBar(SnackBar(
                                      content: Text("Intentar Nuevamente")));
                                  appProvider.changeIsLoading();
                                  return;
                                }
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text(
                                "Añadir Dirreccion",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            )),
                      ),

                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
