
import 'dart:convert';


import 'package:aiskin/send%20reviews%20about%20doctors.dart';
import 'package:aiskin/view%20prescriptions.dart';
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
      home: const ViewAppointmentfull(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewAppointmentfull extends StatefulWidget {
  const ViewAppointmentfull({super.key, required this.title});


  final String title;

  @override
  State<ViewAppointmentfull> createState() => _ViewAppointmentfullState();
}

class _ViewAppointmentfullState extends State<ViewAppointmentfull> {

  _ViewAppointmentfullState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> doctor_ = <String>[];
  List<String> date_ = <String>[];
  List<String> time_ = <String>[];
  List<String> doctor_logid = <String>[];



  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> DOCTOR = <String>[];
    List<String> Date = <String>[];
    List<String> Time = <String>[];
    List<String> d_log = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_viewappointments/';

      var data = await http.post(Uri.parse(url), body: {
        'lid':lid

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        DOCTOR.add(arr[i]['DOCTOR'].toString());
        Date.add(arr[i]['Date'].toString());
        Time.add(arr[i]['Time'].toString());
        d_log.add(arr[i]['d_log'].toString());




      }

      setState(() {


        id_ = id;
        doctor_logid=d_log;
        print("my iddddddddddddddddddddddddddddddd$doctor_logid");

        doctor_=DOCTOR;
        date_=Date;
        time_=Time;
        // station_=Station;


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
                      _buildInfoRow(Icons.person, "Name", doctor_[index]),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.calendar_today, "Date", date_[index]),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.access_time, "Time", time_[index]),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Button color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.chat, color: Colors.white),
                            label: const Text(
                              "",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              final pref = await SharedPreferences.getInstance();
                              String lids = pref.getString('lid').toString();
                              pref.setString("name", doctor_[index]);
                              print("my doctorid issssss${doctor_logid[index]}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IMyChatPage(title: '',doc_id: doctor_logid[index]),
                                ),
                              );
                            },
                          ),
                          // Add this button next to your existing buttons
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.video_call, color: Colors.white),

                            label: const Text(
                              "",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MeetingRequestPage(
                                    bookingId: id_[index],
                                    doctorName: doctor_[index],
                                    appointmentDate: date_[index],
                                    appointmentTime: time_[index],
                                  ),
                                ),
                              ).then((refresh) {
                                if (refresh == true) {
                                  view_notification(); // Refresh the list
                                }
                              });
                            },
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Button color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.chat, color: Colors.white),
                            label: const Text(
                              "",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              final pref = await SharedPreferences.getInstance();
                              String lids = pref.getString('lid').toString();
                              pref.setString("name", doctor_[index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SendReviewPage(title: '',doc_id: id_[index]),
                                ),
                              );
                            },
                          ),

                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [ ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.chat, color: Colors.white),
                        label: const Text(
                          "Prescription",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          final pref = await SharedPreferences.getInstance();
                          String lids = pref.getString('lid').toString();
                          pref.setString("bid", id_[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewPrescriptionfull(title: '',),
                            ),
                          );
                        },
                      ),])

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

