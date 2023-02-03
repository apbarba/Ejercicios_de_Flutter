import 'dart:math';

import 'package:bloc_sample_inclass/home_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'food.dart';
import 'food_generator.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitialState()) {
    on<FetchDataEvent>(_onFetchDataEvent);
  }

  void _onFetchDataEvent(
    FetchDataEvent event,
    Emitter<HomeState> emitter,
  ) async {
    emitter(const HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    bool isSucceed = Random().nextBool();
    if (isSucceed) {
      List<Food> _dummyFoods = FoodGenerator.generateDummyFoods();
      emitter(HomeSuccessFetchDataState(foods: _dummyFoods));
    } else {
      emitter(const HomeErrorFetchDataState(
        errorMessage: "No se ha podido cargar, lo sentimos",
      ));
    }
  }
}
