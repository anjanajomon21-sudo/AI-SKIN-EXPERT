import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

void main() {
  runApp(Symptombasedprediction());
}

class Symptombasedprediction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Symptom based Prediction',
      home: SymptombasedpredictionPage(),
    );
  }
}

class SymptombasedpredictionPage extends StatefulWidget {
  @override
  _SymptombasedpredictionPageState createState() => _SymptombasedpredictionPageState();
}

class _SymptombasedpredictionPageState extends State<SymptombasedpredictionPage> {
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  _SymptombasedpredictionPageState()
  {
    viewreply();

  }

  List<String> checkedItems = [];

  List<String> symptoms_ = <String>[];


  Future<void> viewreply() async {
    List<String> symptoms = <String>[];



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_view_symptoms/';

      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        symptoms.add(arr[i]['name'].toString());

      }

      setState(() {

        symptoms_ = symptoms;
        items = symptoms;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        backgroundColor: Colors.blue,
        title: Text('Symptoms',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: CheckboxListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  items[index],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: checkedItems.contains(items[index]),
                activeColor: Colors.blue,
                checkColor: Colors.white,
                onChanged: (checked) {
                  setState(() {
                    if (checked!) {
                      checkedItems.add(items[index]);
                    } else {
                      checkedItems.remove(items[index]);
                    }
                  });
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          printCheckedItems();
        },
        icon: const Icon(Icons.checklist,color: Colors.white,),
        label: const Text("Predict",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),

    );
  }

  Future<void> printCheckedItems() async {

    String s="";
    print("Checked Items:");
    for (String item in checkedItems) {
      s=s+item+"#";
      print(item);
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/predictdiseasebysymptoms/');
    try {
      final response = await http.post(urls, body: {
        's':s,

        // 'password':password,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {


          String data = jsonDecode(response.body)['data'];

          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Prediction Result'),
              content:  Text(
                'The output predicted by AI is ' + data,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );




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
