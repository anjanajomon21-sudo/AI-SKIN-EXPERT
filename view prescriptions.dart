
import 'dart:convert';


import 'package:aiskin/send%20reviews%20about%20doctors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'chat.dart';
import 'meeting.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewPrescriptionfull(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewPrescriptionfull extends StatefulWidget {
  const ViewPrescriptionfull({super.key, required this.title});


  final String title;

  @override
  State<ViewPrescriptionfull> createState() => _ViewPrescriptionfullState();
}

class _ViewPrescriptionfullState extends State<ViewPrescriptionfull> {

  _ViewPrescriptionfullState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> prescription_ = <String>[];
  List<String> date_ = <String>[];



  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> prescription = <String>[];
    List<String> Date = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String bid = sh.getString('bid').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_viewprescription/';

      var data = await http.post(Uri.parse(url), body: {
        'lid':lid,
        'bid': bid

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        prescription.add(arr[i]['prescription'].toString());
        Date.add(arr[i]['date'].toString());




      }

      setState(() {


        id_ = id;
        prescription_=prescription;
        date_=Date;



      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

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
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text(
          "Bookings",
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(12.0),
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onLongPress: () {
                print("long press $index");
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(Icons.person, "Prescription", prescription_[index]),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.calendar_today, "Date", date_[index]),
                      const SizedBox(height: 8),


                    ],
                  ),
                ),
              ),
            );
          },
        )

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey[700]),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }


}

