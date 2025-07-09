import 'package:vpn_app_case/data/entity/country.dart';

abstract class VpnRepository{

  Future<List<Country>> getCountries(); //ülke listesi gelir.


}