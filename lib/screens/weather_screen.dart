import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/screens/city_search_screen.dart';
import 'package:weather_app/states/weather_state.dart';

const units = 'metric';
const lang = 'vi';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final Completer<void> _completer;
  @override
  void initState() {
    super.initState();
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App using Bloc State Management'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                final typeCity = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CitySearchScreen()));
                if (typeCity != null) {
                  if (context.mounted) {
                    context
                        .read<WeatherBloc>()
                        .add(WeatherEventRequest(city: typeCity));
                  }
                }
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Center(
        child: BlocBuilder(
          bloc: context.read<WeatherBloc>(),
          builder: (context, weatherState) {
            if (weatherState is WeatherStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (weatherState is WeatherStateFailure) {
              return const Center(child: Text('Error: Something went wrong'));
            }
            if (weatherState is WeatherStateSuccess) {
              _completer.complete();

              final weather = weatherState.temp;
              return RefreshIndicator(
                  child: Column(
                    children: [
                      Text(
                          '${weatherState.temp.name} - ${weatherState.temp.sys!.country}'),
                      Image.network(
                          'https://openweathermap.org/img/wn/${weatherState.temp.weather![0].icon}.png'),
                      Text(
                          weatherState.temp.weather![0].description.toString()),
                      Text(
                          'Min temp ${weatherState.temp.main!.tempMin} / Max temp ${weatherState.temp.main!.tempMax}'),
                    ],
                  ),
                  onRefresh: () {
                    context.read<WeatherBloc>().add(WeatherEventRefresh(
                        city: weatherState.temp.name,
                        lang: lang,
                        units: units));
                    return _completer.future;
                  });
            }
            return const Center(child: Text('Select a location first'));
          },
        ),
      ),
    );
  }
}
