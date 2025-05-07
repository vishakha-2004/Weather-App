import 'location.dart';
import 'networking.dart';

const apiKey = '2e2c18dd297ff9a4d0f86abfefa8b77f';
const openWeatherMapURL ='https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCity(String cityName) async{
    var url = await '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelp networkHelp = NetworkHelp(url);
    var weatherData = networkHelp.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelp networkHelp = NetworkHelp('$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelp.getData();
    return weatherData;

  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '⛈️';
    } else if (condition < 400) {
      return '🌧️';
    } else if (condition < 600) {
      return '🌧️';
    } else if (condition < 700) {
      return '❄️';
    } else if (condition < 800) {
      return '🌫️';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
