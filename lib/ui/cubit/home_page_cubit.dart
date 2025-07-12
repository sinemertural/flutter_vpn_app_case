import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_app_case/data/entity/connection_stats.dart';
import 'package:vpn_app_case/data/entity/country.dart';
import 'package:vpn_app_case/data/repository/vpn_repository.dart';

class HomePageCubit extends Cubit<ConnectionStats> {

  final VpnRepository repository;

  Timer? _timer;
  List<Country> freeCountries = [];

  HomePageCubit(this.repository) : super(
    ConnectionStats(
        downloadSpeed: 0,
        uploadSpeed: 0,
        connectedTime: Duration.zero,
        connectedCountry: null)
  );

  Future<void> loadFreeCountries() async {
    final allCountries = await repository.getCountries();
    freeCountries = allCountries.where((c) => c.isFree).toList();
    emit(state);
  }

  void connect(Country country){
    log("Connected to: ${country.name}", name: "HomePageCubit");

    emit(
     ConnectionStats(
         downloadSpeed: 527,
         uploadSpeed: 49,
         connectedTime: Duration(hours: 2,minutes: 41,seconds: 52),
         connectedCountry: country
     )
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      emit(ConnectionStats(
      downloadSpeed: state.downloadSpeed,
      uploadSpeed: state.uploadSpeed,
      connectedTime: state.connectedTime + const Duration(seconds: 1),
      connectedCountry: state.connectedCountry,
      ));
    });
  }

  void disconnect() {
    log("Disconnected", name: "HomePageCubit");
    _timer?.cancel();
    emit(ConnectionStats(
      downloadSpeed: 0,
      uploadSpeed: 0,
      connectedTime: Duration.zero,
      connectedCountry: null,
    ));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }




}