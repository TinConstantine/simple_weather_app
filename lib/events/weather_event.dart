// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherEventRequest extends WeatherEvent {
  String? city;
  String? lang;
  String? units;
  WeatherEventRequest({this.city, this.lang, this.units});

  @override
  List<Object?> get props => [city];
}

class WeatherEventRefresh extends WeatherEvent {
  String? city;
  String? lang;
  String? units;
  WeatherEventRefresh({this.city, this.lang, this.units});

  @override
  List<Object?> get props => [city];
}
