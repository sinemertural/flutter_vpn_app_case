import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vpn_app_case/data/entity/connection_stats.dart';
import 'package:vpn_app_case/data/entity/country.dart';
import 'package:vpn_app_case/data/repository/vpn_repository.dart';

class MockVpnRepository implements VpnRepository {
  Timer? _timer;
  StreamController<ConnectionStats>? _controller;
  Duration _connectedTime = Duration.zero;
  late Country _connectedCountry;


  final List<Country> _countries = [
    Country(
        name: "Italy",
        flag: "assets/flags/it.png",
        city: "",
        locationCount: 4,
        strength: 70,
        isConnected: false,
        isFree: true),

    Country(
        name: "Netherlands",
        flag: "assets/flags/nl.png",
        city: "Amsterdam",
        locationCount: 12,
        strength: 85,
        isConnected: false,
        isFree: false),

    Country(
        name: "Germany",
        flag: "assets/flags/de.png",
        city: "",
        locationCount: 10,
        strength: 90,
        isConnected: false,
        isFree: true),
  ];

  @override
  Future<List<Country>> getCountries() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _countries;
  }

  @override
  Future<List<Country>> getFilteredCountries(String query) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (query.isEmpty) {
      return _countries;
    }
    return _countries
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Stream<ConnectionStats> connect(Country country) {

    _timer?.cancel();
    _controller?.close();
    _connectedCountry = country;


    _controller = StreamController<ConnectionStats>.broadcast(); //// use broadcast because creates a broadcast stream
                                                                  // so multiple widgets can listen for connection updates simultaneously

    _connectedTime = const Duration(hours: 0, minutes: 0, seconds: 0);

    _controller!.add(ConnectionStats(
      downloadSpeed: 527,
      uploadSpeed: 49,
      connectedTime: _connectedTime,
      connectedCountry: country,
    ));

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _connectedTime += const Duration(seconds: 1);
      _controller!.add(ConnectionStats(
        downloadSpeed: 527,
        uploadSpeed: 49,
        connectedTime: _connectedTime,
        connectedCountry: country,
      ));
    });

    return _controller!.stream;
  }

  @override
  void disconnect() {

    print("Connected to: ${_connectedCountry.name} for $_connectedTime");

    _timer?.cancel();
    _timer = null;



    _controller?.add(ConnectionStats(
      downloadSpeed: 0,
      uploadSpeed: 0,
      connectedTime: Duration.zero,
      connectedCountry: null,
    ));
  }
}
