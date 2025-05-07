import 'package:flutter/material.dart';
import 'package:weatherapp/screens/loading_screen.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'package:weatherapp/services/weather.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen(this.locationWeather);
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather = WeatherModel();
  int temperature=1;
  String weatherIcon='';
  String cityName="";
  String message ='';

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData){
    setState(() {
      if(weatherData == null){
        temperature = 0 ;
        //weatherIcon=Text('ERROR',style: TextStyle(color: Colors.red),) as String;
        weatherIcon='ERROR';
        message='unable to get weather data';
        cityName='';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature=temp.toInt();

      int condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);

      message = weather.getMessage(temperature);

      cityName = weatherData['name'];
    });

  }
  AssetImage setImage(int temperature) {
      AssetImage image;
      if (temperature > 25) {
        image = AssetImage('assets/images/sunny.png');
      } else if (temperature > 20) {
        image = AssetImage('assets/images/cloudy.jpg');
      } else if (temperature > 10) {
        image = AssetImage('assets/images/winter.jpg');
      } else {
        image = AssetImage('assets/images/snow.jpg');
      }
      return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            //image: AssetImage('images/location_background.jpg'),
            image: setImage(temperature),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return LoadingScreen();
                      }));
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 40.0,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
                    onPressed: () async {
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      if(typedName != null){
                        var weatherData = await weather.getCity(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
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
              Padding(
                padding: EdgeInsets.only(right: 15.0,bottom: 20),
                child: Text(
                  "$message in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
