import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_app_case/data/entity/country.dart';
import 'package:vpn_app_case/data/repository/mock_vpn_repository.dart';

class ConnectionStatsPageCubit extends Cubit<List<Country>>{

  ConnectionStatsPageCubit() : super(<Country>[]);

  final mockRepo = MockVpnRepository();

  List<Country> countries = [];

  Future<void> loadCountries() async{
    countries = await mockRepo.getCountries();
    emit(countries);
  }

  Future<void> filterCountries(String query) async{
    if(query.isEmpty){
      emit(countries);
    }else{
      var filteredList = countries.where((country) => country.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(filteredList);
    }
  }

}