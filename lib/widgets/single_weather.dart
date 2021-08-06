import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:flutter_weather_app/models/weather_locations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../commons/detailText.dart';

class SingleWeather extends StatefulWidget {
  const SingleWeather({Key key, this.city, this.state}) : super(key: key);
  final String city;
  final String state;
  @override
  _SingleWeatherState createState() => _SingleWeatherState();
}

class _SingleWeatherState extends State<SingleWeather> {
  double deg;
  int humidity;
  String description;
  String confirm;
  double wspeed;
  int pressure;
  String name;
  String icn;
  String icon;

  bool loading = true;
  bool loadingscr = true;
  String substr;
  String localDate;
  String datetime;
  String substring;
  String hr;
  String dt;
  int str_int;
  String date;
  DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm aaa');

  Future getWeather() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=${widget.city}&appid=2de322846c50111a7c09c594eeb72bd8&units=metric');
    var results = json.decode(response.body);
    this.deg = results['main']['temp'];
    this.humidity = results['main']['humidity'];
    this.pressure = results['main']['pressure'];
    this.wspeed = results['wind']['speed'];
    this.name = results['name'];
    this.description = results['weather'][0]['description'];
    this.icon = results['weather'][0]['icon'];
    this.icn = "http://openweathermap.org/img/wn/" + icon + "@2x.png";

    setState(() {
      //condition
      if (icn != null) {
        loadingscr = false;
      }
    });
  }

  //for datetime
  Future getdatetime() async {
    http.Response anotherresponse = await http.get(
        'https://worldtimeapi.org/api/timezone/${widget.state}/${widget.city}');
    //extracting date time
    var data = json.decode(anotherresponse.body);
    this.datetime = data['datetime'];
    final String newDate = data['datetime'];

    //substring
    var string = newDate;

    this.hr = string.substring(11, 13);
    this.str_int = int.parse(hr);
    print(this.hr);
    print(this.str_int);
    this.dt = string.substring(0, 10);

    if (str_int < 12) {
      this.substring = string.substring(11, 16) + ' am';
    } else {
      this.substring = string.substring(11, 16) + ' pm';
    }

    setState(() {
      if (dt != null) {
        this.loading = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
    this.getdatetime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (loadingscr == true)
          ? new Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: CircularProgressIndicator(
                            strokeWidth: 7.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white)),
                      ),
                    ]),
              ),
            )
          : new Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                            ),
                            Row(children: [
                              Text(
                                name.toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              // Container(
                              //   child: Image.network('$icn'),
                              // ),
                            ]),
                            SizedBox(
                              height: 3,
                            ),

                            //using ifelse
                            Container(
                                child: (loading == true)
                                    ? new Container(
                                        child: SizedBox(
                                          height: 10,
                                          width: 80,
                                          child: LinearProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white)),
                                        ),
                                      )
                                    : new Container(
                                        child: smallfont(
                                          value: dt.toString(),
                                        ),
                                      )),
                            SizedBox(
                              height: 5,
                            ),

                            Container(
                                child: (loading == true)
                                    ? new Container(
                                        child: SizedBox(
                                          height: 10,
                                          width: 80,
                                          child: LinearProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white)),
                                        ),
                                      )
                                    : new Container(
                                        child: Text(
                                          substring.toString(),
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(
                                (deg.toString() != null)
                                    ? deg.toString() + '\u2103'
                                    : '-',
                                style: GoogleFonts.lato(
                                  fontSize: 60,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                child: Image.network('$icn'),
                              ),
                            ]),
                            bigfont(
                              value: description.toString().toUpperCase(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                smallfont(
                                  value: 'Wind speed',
                                ),
                                bigfont(
                                  value: wspeed.toString(),
                                ),
                                smallfont(
                                  value: 'km/h',
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                smallfont(
                                  value: 'Pressure',
                                ),
                                bigfont(
                                  value: pressure.toString(),
                                ),
                                smallfont(
                                  value: 'hPa',
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                smallfont(
                                  value: 'Humidity',
                                ),
                                bigfont(
                                  value: humidity.toString(),
                                ),
                                smallfont(
                                  value: '%',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
