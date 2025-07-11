import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_app_case/data/entity/connection_stats.dart';
import 'package:vpn_app_case/data/entity/country.dart';

class HomePageCubit extends Cubit<ConnectionStats> {

  Timer? _timer;

  HomePageCubit() : super(
    ConnectionStats(
        downloadSpeed: 0,
        uploadSpeed: 0,
        connectedTime: Duration.zero,
        connectedCountry: null)
  );

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