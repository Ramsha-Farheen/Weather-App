import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/weather_locations.dart';
import '../widgets/buildin_transform.dart';
import '../widgets/single_weather.dart';
import '../widgets/slider_dot.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentPage = 0;
  String bgImg;
  bool loading = true;

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bgImg = 'assets/sunny.jpg';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(children: [
          Image.asset(
            bgImg,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.black38),
          ),
          Container(
            margin: EdgeInsets.only(top: 140, left: 15),
            child: Row(
              children: [
                for (int i = 0; i < locationList.length; i++)
                  if (i == _currentPage) SliderDot(true) else SliderDot(false)
              ],
            ),
          ),
          TransformerPageView(
            scrollDirection: Axis.horizontal,
            transformer: ScaleAndFadeTransformer(),
            viewportFraction: 0.8,
            onPageChanged: _onPageChanged,
            itemCount: locationList.length,
            itemBuilder: (ctx, i) => SingleWeather(
              city: locationList[i].city,
              state: locationList[i].state,
            ),
          ),
        ]),
      ),
    );
  }
}
