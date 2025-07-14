import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_app_case/data/entity/country.dart';
import 'package:vpn_app_case/data/repository/vpn_repository.dart';

class ConnectionStatsPageCubit extends Cubit<List<Country>> {
  final VpnRepository repository;

  ConnectionStatsPageCubit(this.repository) : super([]);

  Future<void> loadCountries() async {
    final countries = await repository.getCountries();
    emit(countries);
  }

  Future<void> filterCountries(String query) async {
    final filtered = await repository.getFilteredCountries(query);
    emit(filtered);
  }
}


