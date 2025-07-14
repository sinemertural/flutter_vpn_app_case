import 'package:vpn_app_case/data/entity/country.dart';

class ConnectionStats{
  int downloadSpeed ;
  int uploadSpeed ;
  Duration connectedTime ; // current VPN connection time
  Country? connectedCountry ; // The currently connected VPN country. for example => Almanya

  ConnectionStats({
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.connectedTime,
    this.connectedCountry}); //didn't use "required" because => Country? connectedCountry


}