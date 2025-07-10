import 'package:flutter_bloc/flutter_bloc.dart';

class BasePageCubit extends Cubit<int>{
  BasePageCubit() : super(0);

  void changPage(int index) {
    emit(index);
  }
}