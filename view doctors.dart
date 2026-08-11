
import 'dart:convert';

import 'package:aiskin/view%20doctor%20shedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'chat.dart';
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
      home: const ViewDoctors(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewDoctors extends StatefulWidget {
  const ViewDoctors({super.key, required this.title});


  final String title;

  @override
  State<ViewDoctors> createState() => _ViewDoctorsState();
}

class _ViewDoctorsState extends State<ViewDoctors> {

  _ViewDoctorsState() {
    view_notification();
  }


  List<String> id_ = <String>[];
  List<String> lid_ = <String>[];
  List<String> doctorname_ = <String>[];
  List<String> mobileno_ = <String>[];
  List<String> email_ = <String>[];
  List<String> pin_ = <String>[];
  List<String> exeperience_ = <String>[];
  List<String> qualification_ = <String>[];
  List<String> photo_ = <String>[];



  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> lid = <String>[];
    List<String> doctorname = <String>[];
    List<String> mobileno = <String>[];
    List<String> email = <String>[];
    List<String> pin = <String>[];
    List<String> exeperience = <String>[];
    List<String> qualification = <String>[];
    List<String> photo = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String img_url = sh.getString('img_url').toString();
      String url = '$urls/user_viewdoctors/';

      var data = await http.post(Uri.parse(url), body: {
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        lid.add(arr[i]['lid'].toString());
        doctorname.add(arr[i]['Doctorname']);
        mobileno.add(arr[i]['Mobileno']);
        email.add(arr[i]['email']);
        qualification.add(arr[i]['Qualification']);
        exeperience.add(arr[i]['Exeperience']);
        pin.add(arr[i]['pin']);
        photo.add(img_url+ arr[i]['Photo']);

      }

      setState(() {
        id_ = id;
        lid_ = lid;
        doctorname_=doctorname;
        mobileno_=mobileno;
        email_=email;
        qualification_=qualification;
        exeperience_=exeperience;
        pin_=pin;
        photo_=photo;

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
        // appBar: AppBar(
        //   leading: BackButton( ),
        //   // TRY THIS: Try changing the color here to a specific color (to
        //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        //   // change color while the other colors stay the same.
        //   backgroundColor: Theme.of(context).colorScheme.primary,
        //
        //   title: Text("Doctors",style: TextStyle(
        //     color: Colors.white
        //   ),),
        // ),


        appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          backgroundColor: Colors.blue,
          title: const Text(
            "Doctors",
            style: TextStyle(color: Colors.white),
          ),
        ),



      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: id_.length, // Assuming id_ is accessible here
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                    child: Image.network(
                      photo_[index],
                      height: 200.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200.0,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, size: 100.0, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorname_[index],
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Icon(Icons.phone, size: 16.0, color: Colors.grey),
                            const SizedBox(width: 8.0),
                            Text(mobileno_[index]),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            const Icon(Icons.email, size: 16.0, color: Colors.grey),
                            const SizedBox(width: 8.0),
                            Text(email_[index]),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            const Icon(Icons.location_pin, size: 16.0, color: Colors.grey),
                            const SizedBox(width: 8.0),
                            Text(pin_[index]),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            const Icon(Icons.school, size: 16.0, color: Colors.grey),
                            const SizedBox(width: 8.0),
                            Text(qualification_[index]),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            const Icon(Icons.work_history, size: 16.0, color: Colors.grey),
                            const SizedBox(width: 8.0),
                            Text("Experience: ${exeperience_[index]}"),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () async {
                                final pref = await SharedPreferences.getInstance();
                                pref.setString("did", id_[index]);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ViewDoctorsSchedule(title: ""),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.calendar_today),
                              label: const Text("Schedule"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            // ElevatedButton.icon(
                            //   onPressed: () async {
                            //     final pref = await SharedPreferences.getInstance();
                            //     pref.setString("tid", lid_[index]);
                            //     pref.setString("name", doctorname_[index]);
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => IMyChatPage(title: '',),
                            //       ),
                            //     );
                            //   },
                            //   icon: const Icon(Icons.chat),
                            //   label: const Text("Chat"),
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: Colors.blue,
                            //     foregroundColor: Colors.white,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(8.0),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}