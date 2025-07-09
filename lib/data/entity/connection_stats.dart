import 'package:vpn_app_case/data/entity/country.dart';

class ConnectionStats{
  int downloadSpeed ;
  int uploadSpeed ;
  Duration connectedTime ;
  Country? connectedCountry ;

  ConnectionStats({
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.connectedTime,
    required this.connectedCountry});


}