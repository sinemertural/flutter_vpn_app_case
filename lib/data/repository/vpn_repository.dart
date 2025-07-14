import 'package:flutter/material.dart';
import 'package:vpn_app_case/data/entity/connection_stats.dart';
import 'package:vpn_app_case/data/entity/country.dart';

abstract class VpnRepository {
  Future<List<Country>> getCountries();
  Future<List<Country>> getFilteredCountries(String query);
  Stream<ConnectionStats> connect(Country country);
  void disconnect();
}
