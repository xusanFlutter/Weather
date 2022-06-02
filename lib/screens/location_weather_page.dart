import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:weather_app/location/location_weather.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/screens/current_weather.dart';
import 'package:weather_app/service/weather_service.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  TextEditingController controller = TextEditingController();
  DataServise2 dataServise = DataServise2();
  Weather weather = Weather();
  bool isFeatch = false;
  String? lat, long, country;
  @override
  void initState() {
    super.initState();
    getLocation();
    Timer(
      const Duration(seconds: 2),
      () async {
        weather = await dataServise.fetchData(lat, long);
        HapticFeedback.lightImpact();
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: Text(
          weather.name,
          style: const TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const CurrentWeather(),
              ),
            );
          },
          icon: const Icon(
            Icons.search,
            size: 40,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
            colors: [
              // Colors.white,
              Colors.blue,
              Colors.blue,
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            weather = await dataServise.fetchData(lat, long);
            HapticFeedback.lightImpact();
            setState(() {});
          },
          child: ListView(
            children: [
              const SizedBox(height: 10),
              Column(
                children: [
                  const SizedBox(height: 100),
                  Image.network(
                    'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                  ),
                  Text(
                    '${weather.temp} °C',
                    style: const TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    weather.description.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    dayOrNight(),
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () async {
                  //     weather = await dataServise.fetchData(lat, long);
                  //     HapticFeedback.lightImpact();
                  //     setState(() {});
                  //   },
                  //   child: GlassmorphicContainer(
                  //     width: 150,
                  //     height: 50,
                  //     borderRadius: 10,
                  //     blur: 20,
                  //     alignment: Alignment.bottomCenter,
                  //     border: 2,
                  //     linearGradient: LinearGradient(
                  //         begin: Alignment.topLeft,
                  //         end: Alignment.bottomRight,
                  //         colors: [
                  //           const Color(0xFFffffff).withOpacity(0.2),
                  //           const Color(0xFFFFFFFF).withOpacity(0.2),
                  //         ],
                  //         stops: const [
                  //           0.1,
                  //           1,
                  //         ]),
                  //     borderGradient: LinearGradient(
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.bottomRight,
                  //       colors: [
                  //         const Color(0xFFffffff).withOpacity(0.5),
                  //         const Color((0xFFFFFFFF)).withOpacity(0.5),
                  //       ],
                  //     ),
                  //     child: const Center(
                  //       child: Text(
                  //         'Search',
                  //         style: TextStyle(
                  //           fontSize: 20,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 30),
                ],
              ),
              GlassmorphicContainer(
                width: 350,
                height: 350,
                borderRadius: 20,
                blur: 20,
                alignment: Alignment.bottomCenter,
                border: 2,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFffffff).withOpacity(0.1),
                      const Color(0xFFFFFFFF).withOpacity(0.05),
                    ],
                    stops: const [
                      0.1,
                      1,
                    ]),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFffffff).withOpacity(0.5),
                    const Color((0xFFFFFFFF)).withOpacity(0.5),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Feels Like',
                          style: TextStyle(
                            color: Colors.grey[200]!.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          'Humidity',
                          style: TextStyle(
                            color: Colors.grey[200]!.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${weather.feelsLike} °C',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '${weather.humidity} %',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    /////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Wind Speed',
                          style: TextStyle(
                            color: Colors.grey[200]!.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          'Pressure',
                          style: TextStyle(
                            color: Colors.grey[200]!.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${weather.wind} km/h',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${weather.pressure}abar',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Data were obtained',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.network(
                    'https://openweathermap.org/themes/openweathermap/assets/img/logo_white_cropped.png',
                    width: 70,
                    height: 70,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getWeather() async {
    weather = await dataServise.fetchData(lat, long);
    HapticFeedback.lightImpact();
    setState(() {});
  }

  dayOrNight() {
    if (weather.icon.contains('n')) {
      return 'Night';
    } else if (weather.icon.contains('d')) {
      return 'Day';
    }
  }

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();
    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);
      setState(() {
        lat = locationData.latitude!.toStringAsFixed(2);
        long = locationData.longitude!.toStringAsFixed(2);
        country = placeMark?.country ?? 'city name';
      });
    }
  }
}
