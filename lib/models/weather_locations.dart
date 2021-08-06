import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WeatherLocation {
  final String city;
  final String state;

  WeatherLocation({
    @required this.city,
    @required this.state,
  });
}

final locationList = [
  WeatherLocation(
    state: 'Asia',
    city: 'Karachi',
  ),
  WeatherLocation(
    state: 'Asia',
    city: 'Baku',
  ),
  WeatherLocation(
    state: 'America',
    city: 'Chicago',
  ),
  WeatherLocation(
    state: 'Europe',
    city: 'Istanbul',
  ),
];
