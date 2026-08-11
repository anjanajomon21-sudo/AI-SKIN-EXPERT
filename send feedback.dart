
// import 'package:clinicpharma/signUpmain.dart';
// import 'package:clinicpharma/signup.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';


void main() {
  runApp(const sendcomplaint());
}

class sendcomplaint extends StatelessWidget {
  const sendcomplaint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const sendfeedbackPage(title: 'Login'),
    );
  }
}

class sendfeedbackPage extends StatefulWidget {
  const sendfeedbackPage({super.key, required this.title});

  final String title;

  @override
  State<sendfeedbackPage> createState() => _sendfeedbackPageState();
}

class _sendfeedbackPageState extends State<sendfeedbackPage> {


  TextEditingController FeedbackController = new TextEditingController();
  // TextEditingController passwordController = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white,),
          backgroundColor: Colors.blue,
          title: Text("Feedbacks",style: TextStyle(color: Colors.white),),
        ),


          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "We value your feedback",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Please let us know your thoughts or suggestions below:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 20),

                // Feedback TextField
                TextField(
                  maxLines: 5,
                  controller: FeedbackController,
                  decoration: InputDecoration(
                    labelText: "Your Feedback",
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.brown, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.brown.shade50,
                  ),
                ),
                const SizedBox(height: 25),

                // Send Button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    _send_data();
                  },
                  icon: const Icon(Icons.send),
                  label: const Text(
                    'Send Feedback',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )

      ),
    );
  }


  void _send_data() async{



    String Feedback=FeedbackController.text;
    // String password=passwordController.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_sendfeedback/');
    try {
      final response = await http.post(urls, body: {
        'feedback':Feedback,
        'lid':lid,
        // 'password':password,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {


          Fluttertoast.showToast(msg: 'send successfully');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => MyHomePage(),));
        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

}
