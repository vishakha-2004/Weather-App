import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:clima/screens/loading_screen.dart';

class NetworkHelp{
  NetworkHelp(this.url);

  final String url;

  Future<dynamic> getData() async{
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    }else{
      print(response.statusCode);
    }
  }
}