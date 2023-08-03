import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;

class JadwalScreen extends StatefulWidget {
  final String lokasi;
  final String lokasiID;

  const JadwalScreen({Key? key, required this.lokasi,  required this.lokasiID}) : super(key: key);

  @override
  JadwalScreenState createState() => JadwalScreenState();
}

class JadwalScreenState extends State<JadwalScreen>{

  String shubuh = '';
  String dzuhur = '';
  String ashar = '';
  String maghrib = '';
  String isya = '';

  String urlAPI = '';

  @override
  void initState() {
    super.initState();

    // ignore: prefer_interpolation_to_compose_strings
    urlAPI = "https://prayertimes.api.abdus.dev/api/diyanet/prayertimes?location_id=" + widget.lokasiID;

    getJadwal();
  }

  Future<void> getJadwal() async {

    SmartDialog.showLoading(
      msg: "Loading.."
    );
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(urlAPI));
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        shubuh = data[0]['fajr'] ?? '-';
        dzuhur = data[0]['dhuhr'] ?? '-';
        ashar = data[0]['asr'] ?? '-';
        maghrib = data[0]['maghrib'] ?? '-';
        isya = data[0]['isha'] ?? '-';
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

    Widget cardInformation(jadwalShalat, jam){

      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: const BorderRadius.all(
            Radius.circular(10)
          ),
          border: Border.all(color: Colors.blue),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(jadwalShalat, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
            Text(jam, style: const TextStyle(color: Colors.white),)

          ],
        )
      );

    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("Jadwal Shalat"),
        actions: [
          Row(
            children: [
              const Icon(Icons.pin_drop_outlined),
              Text(widget.lokasi),
              const SizedBox(width: 10,)
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [

            cardInformation("Shubuh", shubuh),
            const SizedBox(height: 10),
            cardInformation("Dzuhur", dzuhur),
            const SizedBox(height: 10),
            cardInformation("Ashar", ashar),
            const SizedBox(height: 10),
            cardInformation("Maghrib", maghrib),
            const SizedBox(height: 10),
            cardInformation("Isya", isya),

          ],
        )
      )
    );

  }
}