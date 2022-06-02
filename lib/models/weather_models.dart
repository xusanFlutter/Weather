class Weather {
  final double temp;
  final String description;
  final String name;
  final String icon;
  final double wind;
  final double feelsLike;
  final int pressure;
  final int humidity;

  Weather({
    this.temp = 0,
    this.description = '',
    this.name = 'City Name',
    this.icon = '02d',
    this.wind = 0,
    this.feelsLike = 0,
    this.pressure = 0,
    this.humidity = 0,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'] ?? '',
      description: json['weather'][0]['description'] ?? '',
      name: json['name'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      wind: json['wind']['speed'] ?? '',
      feelsLike:  json['main']['feels_like'] ?? '',
      pressure:  json['main']['pressure'] ?? '',
      humidity:  json['main']['humidity'] ?? '',
    );
  }
}
