import 'package:flutter/material.dart';
import 'package:chillax/utilities/constants.dart';
import 'package:chillax/services/weather.dart';
import 'city_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chillax/utilities/monthFinder.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = '';
  String cityName = '';
  String weatherCondition = '';
  String humidity = '';
  String feels_like = '';
  String windSpeed = '';
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        cityName = '';
        weatherCondition = '';
        windSpeed = '';
        humidity = '';
        feels_like = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
      weatherCondition = weatherData['weather'][0]['main'].toString();
      windSpeed = weatherData['wind']['speed'].toString();
      feels_like = weatherData['main']['feels_like'].toString();
      humidity = weatherData['main']['humidity'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var typedName = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CityScreen();
              },
            ),
          );
          if (typedName != null) {
            var weatherData = await weather.getCityWeather(typedName);
            updateUI(weatherData);
          }
        },
        child: Icon(
          Icons.search_outlined,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xff082032),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff082032),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cityName,
                                    style: GoogleFonts.asap(fontSize: 30)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Today,' +
                                        ' ' +
                                        selectedDate.day.toString() +
                                        ' '),
                                    Text(
                                      month(selectedDate) + ' ',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              var weatherData =
                                  await weather.getLocationWeather();
                              updateUI(weatherData);
                            },
                            icon: const Icon(
                              Icons.location_on,
                              size: 45.0,
                              color: Color(0xffFF4C29),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: const BoxDecoration(
                          color: Color(0xff334756),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$temperature°',
                            style: kTempTextStyle,
                          ),
                          Text(
                            weatherIcon,
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xff334756),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Text('Weather Condtions',style: GoogleFonts.asap(fontSize: 15),)),
                              Expanded(
                                child: Text(
                            weatherCondition,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.asap(fontSize: 30),
                          ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xff334756),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.2,
                          child: Column(
                            children: [
                              Expanded(child: Text('Feels Like',style: GoogleFonts.asap(fontSize: 15),)),
                              Expanded(
                                child: Text(
                                  feels_like+'° ',
                                  style: GoogleFonts.asap(fontSize: 30),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xff334756),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Text('Wind speed',style: GoogleFonts.asap(fontSize: 15),)),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      windSpeed,
                                      style: GoogleFonts.asap(fontSize: 30),
                                    ),
                                    Text('  m/s'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xff334756),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Text('Humidity', style: GoogleFonts.asap(fontSize: 15),),),
                              Expanded(
                                child: Text(
                                  humidity,
                                  style: GoogleFonts.asap(fontSize: 30),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}