import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:uas_rodhiyatun/cuaca.dart';
import 'package:uas_rodhiyatun/jadwal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAS Mobprog Rodhiyatun Mardiah',
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.blue
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'UAS Mobprog Rodhiyatun Mardiah'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.blue,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: const TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'NIM',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )
            ),
            const Text(
              '0102520029',
              style: TextStyle(
                color: Colors.blue
              )
            ),

            const SizedBox(height: 10,),

            const Text(
              'Nama',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )
            ),
            const Text(
              'Rodhiyatun Mardiah',
              style: TextStyle(
                color: Colors.blue
              )
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const CuacaScreen(apiKey: "08669e9f91374a39965134846230308", kota: "Semarang",)
                ));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.blue, width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.cloud_outlined, color: Colors.white,),
                    Text("Cuaca", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                  ],
                )
              )
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const JadwalScreen(lokasi: "Semarang", lokasiID: "12756")
                ));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.blue, width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.alarm, color: Colors.white,),
                    Text("Jadwal Shalat", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                  ],
                )
              )
            ),

          ],
        )
      ),
    );
  }
}
