import 'package:weatherapp/screens/location_screen.dart';
import 'package:weatherapp/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';


const apiKey = '2e2c18dd297ff9a4d0f86abfefa8b77f';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SpinKitDoubleBounce(
              //   color: Colors.white,
              //   size: 100,
              // ),
              Lottie.asset(
                'assets/images/cloiud_animation.json',
                fit: BoxFit.cover,
              ),
              Text('Contacting the Clouds...',
                style: GoogleFonts.albertSans(
                  textStyle: TextStyle(fontSize: 30), fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)
              )
            ],
          ),
        ),
      ),
    );
  }
}
