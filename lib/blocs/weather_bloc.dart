import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/repositories/weather_repositories.dart';
import 'package:weather_app/states/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherStateInitial()) {
    on<WeatherEventRefresh>((weatherEventRefresh, emit) async {
      emit(WeatherStateLoading());
      try {
        final weather = await WeatherRepositories.fetchTemperatures(
            city: weatherEventRefresh.city,
            lang: weatherEventRefresh.lang,
            units: weatherEventRefresh.units);
        emit(WeatherStateSuccess(temp: weather));
      } catch (_) {
        emit(WeatherStateFailure());
      }
    });
    on<WeatherEventRequest>((weatherEventRequest, emit) async {
      emit(WeatherStateLoading());
      try {
        final weather = await WeatherRepositories.fetchTemperatures(
            city: weatherEventRequest.city,
            lang: weatherEventRequest.lang,
            units: weatherEventRequest.units);
        emit(WeatherStateSuccess(temp: weather));
      } catch (_) {
        emit(WeatherStateFailure());
      }
    });
  }
}
