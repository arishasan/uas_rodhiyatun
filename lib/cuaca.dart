import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;

class CuacaScreen extends StatefulWidget {
  final String kota;
  final String apiKey;

  const CuacaScreen({Key? key, required this.kota, required this.apiKey}) : super(key: key);

  @override
  CuacaScreenState createState() => CuacaScreenState();
}

class CuacaScreenState extends State<CuacaScreen>{

  String lat = '';
  String long = '';
  String temperatureC = '';
  String temperatureF = '';
  String feelsC = '';
  String feelsF = '';
  String humidity = '';
  String condition = '';
  String urlAPI = "";

  @override
  void initState() {
    super.initState();
    // ignore: prefer_interpolation_to_compose_strings
    urlAPI = "https://api.weatherapi.com/v1/current.json?key=" + widget.apiKey + "&q=" + widget.kota;
    getCuaca();
  }

  Future<void> getCuaca() async {

    SmartDialog.showLoading(
      msg: "Loading.."
    );
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(urlAPI));
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        lat = data['location']['lat'].toString();
        long = data['location']['lon'].toString();
        temperatureC = data['current']['temp_c'].toString();
        temperatureF = data['current']['temp_f'].toString();
        feelsC = data['current']['feelslike_c'].toString();
        feelsF = data['current']['feelslike_f'].toString();
        condition = data['current']['condition']['text'];
        humidity = data['current']['humidity'].toString();
      });

    } finally {
      client.close();
    }

    SmartDialog.dismiss();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget cardInformation(title, sub){

      return Container(
        margin: const EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10)
          ),
          border: Border.all(color: Colors.blue)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(title),
            Text(sub, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),

          ],
        )
      );

    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("Cuaca", ),
        actions: [
          Row(
            children: [
              const Icon(Icons.pin_drop_outlined),
              Text(widget.kota),
              const SizedBox(width: 10,)
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [


            const SizedBox(height: 10),

            cardInformation("Kondisi", condition),
            // ignore: prefer_interpolation_to_compose_strings
            cardInformation("Suhu (C)", temperatureC + "°C"),
            // ignore: prefer_interpolation_to_compose_strings
            cardInformation("Terasa Seperti Suhu (C)", feelsC + "°C"),
            // ignore: prefer_interpolation_to_compose_strings
            cardInformation("Suhu (F)", temperatureF + "°F"),
            // ignore: prefer_interpolation_to_compose_strings
            cardInformation("Terasa Seperti Suhu (F)", feelsF + "°F"),
            // ignore: prefer_interpolation_to_compose_strings
            cardInformation("Kelembapan", humidity),

          ],
        )
      )
    );

  }
}