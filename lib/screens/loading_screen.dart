import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

const apiKey = '158f527283d0358aca7a97d1e10715c4';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat, long;
  @override
  void initState() {
    super.initState();
    getLocation();
  }
  void getLocation() async{

    Location location = Location();
    await location.getCurrentLocation();
    lat= (location.lat);
    long= (location.long);
    getData();
  }
  void getData()async{
    print(lat);
    print(long);
    http.Response response = await http.get('http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=158f527283d0358aca7a97d1e10715c4&units=metric');

    if(response.statusCode==200){

      var data = jsonDecode(response.body);


      Navigator.push(context, MaterialPageRoute(builder: (context){return LocationScreen(weatherData:data);}));
    }else print(response.statusCode );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
        ),
      ),
    );
  }
}
