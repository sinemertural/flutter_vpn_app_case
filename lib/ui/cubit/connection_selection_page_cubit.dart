import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_app_case/data/entity/country.dart';
import 'package:vpn_app_case/data/repository/vpn_repository.dart';

class ConnectionStatsPageCubit extends Cubit<List<Country>> {
  final VpnRepository repository;
  List<Country> countries = [];

  ConnectionStatsPageCubit(this.repository) : super([]);

  Future<void> loadCountries() async {
    countries = await repository.getCountries();
    emit(countries);
  }

  Future<void> filterCountries(String query) async {
    if (query.isEmpty) {
      emit(countries);
    } else {
      final filtered = countries.where(
            (c) => c.name.toLowerCase().contains(query.toLowerCase()),
      ).toList();
      emit(filtered);
    }
  }
}
