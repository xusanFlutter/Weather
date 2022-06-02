import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/service/weather_service.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  TextEditingController controller = TextEditingController();
  DataServise dataServise = DataServise();
  Weather weather = Weather();

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
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
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
            weather = await dataServise.fetchData(controller.text);
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
                    weather.description,
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
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: TextFormField(
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: controller,
                      decoration: const InputDecoration(
                        labelText: 'City name *',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      if (controller.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: const Text('Text field must be filled!'),
                            action: SnackBarAction(
                              label: 'ok',
                              onPressed: () {},
                            ),
                          ),
                        );
                      } else {
                        weather = await dataServise.fetchData(controller.text);
                      }
                      HapticFeedback.lightImpact();
                      setState(() {});
                    },
                    child: GlassmorphicContainer(
                      width: 150,
                      height: 50,
                      borderRadius: 10,
                      blur: 20,
                      alignment: Alignment.bottomCenter,
                      border: 2,
                      linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.2),
                            const Color(0xFFFFFFFF).withOpacity(0.2),
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
                      child: const Center(
                        child: Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
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

  dayOrNight() {
    if (weather.icon.contains('n')) {
      return 'Night';
    } else if (weather.icon.contains('d')) {
      return 'Day';
    }
  }
}
