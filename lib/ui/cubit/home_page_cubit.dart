import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_app_case/data/entity/connection_stats.dart';
import 'package:vpn_app_case/data/entity/country.dart';
import 'package:vpn_app_case/data/repository/vpn_repository.dart';

class HomePageCubit extends Cubit<ConnectionStats> {
  final VpnRepository repository;

  List<Country> freeCountries = [];
  StreamSubscription? _subscription; //I can say _subscription is listener so I say "I will listen to this stream, and notify me whenever new data arrives."

  HomePageCubit(this.repository)
      : super(ConnectionStats(
      downloadSpeed: 0,
      uploadSpeed: 0,
      connectedTime: Duration.zero,
      connectedCountry: null));

  Future<void> loadFreeCountries() async {
    final allCountries = await repository.getCountries();
    freeCountries = allCountries.where((c) => c.isFree).toList();
    emit(state);
  }

  void connect(Country country) {
    _subscription?.cancel(); // stop listening to the old subscription
    _subscription = repository.connect(country).listen((stats) { // start listening to  new subscription
      emit(stats);
    });
  }

  void disconnect() {
    repository.disconnect();
  }

  @override
  Future<void> close() {
    _subscription?.cancel(); //stop listen to subscription
    return super.close(); // close cubit
  }

}
