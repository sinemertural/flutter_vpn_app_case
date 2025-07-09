import 'package:vpn_app_case/data/entity/country.dart';
import 'package:vpn_app_case/data/repository/vpn_repository.dart';

class MockVpnRepository implements VpnRepository{

  @override
  Future<List<Country>> getCountries() async {

    var countryList = <Country>[];

    var c1 = Country(
        name: "Italy",
        flag: "assets/flags/it.png",
        city: "",
        locationCount: 4,
        strength: 70,
        isConnected: false);

    var c2 = Country(
        name: "Netherlands",
        flag: "assets/flags/nl.png",
        city: "Amsterdam",
        locationCount: 12,
        strength: 85,
        isConnected: false);

    var c3 = Country(
        name: "Germany",
        flag: "assets/flags/de.png",
        city: "",
        locationCount: 10,
        strength: 90,
        isConnected: false);

    countryList.add(c1);
    countryList.add(c2);
    countryList.add(c3);

    return Future.delayed(Duration(milliseconds: 500), () => countryList); //gerçek bir apı den almış gibi bekleme efekti verir.

  }


}