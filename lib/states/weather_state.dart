import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object> get props => [];
}

class WeatherStateInitial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateSuccess extends WeatherState {
  Temperatures temp;
  WeatherStateSuccess({required this.temp});
  @override
  List<Object> get props => [temp];
}

class WeatherStateFailure extends WeatherState {}
