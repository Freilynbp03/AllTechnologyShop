class AddressItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const COUNTRY = "country";
  static const PROVINCE = "province";
  static const MUNICIPALITY = "municipality";
  static const SECTOR = "sector";
  static const STREET = "street";
  static const APT = "apt";


  String _id;
  String _name;
  String _country;
  String _province;
  String _municipality;
  String _sector;
  String _street;
  String _apt;


  //  getters
  String get id => _id;

  String get name => _name;

  String get country => _country;

  String get province => _province;

  String get municipality => _municipality;

  String get sector => _sector;

  String get street => _street;

  String get apt => apt;




  AddressItemModel.fromMap(Map data){
    _id = data[ID];
    _name =  data[NAME];
    _country = data[COUNTRY];
    _province = data[PROVINCE];
    _municipality = data[MUNICIPALITY];
    _sector = data[SECTOR];
    _street = data[STREET];
    _apt = data[APT];
  }

  Map toMap() => {
    ID: _id,
    NAME: _name,
    COUNTRY: _country,
    PROVINCE: _province,
    MUNICIPALITY: _municipality,
    SECTOR: _sector,
    STREET: _street,
    APT: _apt

  };
}