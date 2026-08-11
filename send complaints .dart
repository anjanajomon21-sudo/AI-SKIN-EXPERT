
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
      home: const sendcomplaintPage(title: 'Login'),
    );
  }
}

class sendcomplaintPage extends StatefulWidget {
  const sendcomplaintPage({super.key, required this.title});

  final String title;

  @override
  State<sendcomplaintPage> createState() => _sendcomplaintPageState();
}

class _sendcomplaintPageState extends State<sendcomplaintPage> {


  TextEditingController complaintController = new TextEditingController();
  // TextEditingController passwordController = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white,),
          backgroundColor: Colors.blue,
          title: Text("Send Complaints",style: TextStyle(color: Colors.white),),
        ),


        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16), // Added padding for overall spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              // Page title
              Text(
                "Submit a Complaint",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Complaint Text Field
              TextField(
                minLines: 5,
                maxLines: 6,
                controller: complaintController,
                decoration: InputDecoration(
                  labelText: "Your Complaint",
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: Colors.brown.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.brown.shade700, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Send Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                onPressed: _send_data,
                icon: const Icon(Icons.send),
                label: const Text(
                  "Send Complaint",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }


  void _send_data() async{


    String complaint=complaintController.text;
    // String password=passwordController.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_sendcomplaint/');
    try {
      final response = await http.post(urls, body: {
        'complaint':complaint,
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
