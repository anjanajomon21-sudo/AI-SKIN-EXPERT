import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class IMyChatPage extends StatefulWidget {
  const IMyChatPage({super.key, required this.title,required this.doc_id});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String doc_id;

  @override
  State<IMyChatPage> createState() => _IMyChatPageState();
}

class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}

class _IMyChatPageState extends State<IMyChatPage> {
  int _counter = 0;
  String name = "";

  _IMyChatPageState() {
    Timer.periodic(Duration(seconds: 2), (_) {
      view_message();

      // setState(() {
      //
      //   List<ChatMessage> messages1= messages;
      //   messages1.add(ChatMessage(messageContent: "Hello, Will", messageType: "sender"));
      //   setState(() {
      //     messages=messages1;
      //   });
      // });
      //
      // print("Hiii");
      // // Runs after every 1000ms
    });
  }

  List<ChatMessage> messages = [];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  TextEditingController te_message = TextEditingController();

  List<int> from_id_ = <int>[];
  List<int> to_id_ = <int>[];
  List<String> message_ = <String>[];
  List<String> date_ = <String>[];
  List<String> time_ = <String>[];

  Future<void> view_message() async {
    final pref = await SharedPreferences.getInstance();
    name = pref.getString("name").toString();

    // setState(() {
    //   name = name;
    // });

    List<int> from_id = <int>[];
    List<int> to_id = <int>[];
    List<String> message = <String>[];
    List<String> date = <String>[];
    List<String> time = <String>[];

    try {
      final pref = await SharedPreferences.getInstance();
      String urls = pref.getString('url').toString();
      String url = '$urls/ins_and_userviewchat/';

      var data = await http.post(Uri.parse(url), body: {
        'from_id': pref.getString("lid").toString(),
        'toid': widget.doc_id
      });
      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];

      messages.clear();
      print("rrrrrrrrrrrrrrrrrrrrrr");
      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        from_id.add(arr[i]['from']);
        message.add(arr[i]['message']);
        date.add(arr[i]['date']);

        if (pref.getString("lid").toString() == arr[i]['from'].toString()) {
          messages.add(ChatMessage(
              messageContent: arr[i]['message'], messageType: "sender"));
        } else {
          messages.add(ChatMessage(
              messageContent: arr[i]['message'], messageType: "receiver"));
        }
      }

      // messages.add(ChatMessage(messageContent: "....", messageType: "sender"));

      setState(() {
        from_id_ = from_id;
        to_id_ = to_id;
        message_ = message;
        date_ = date;
        time_ = time;

        messages = messages;
      });
      print("yyyyyyyyyyyyyyyyyyy");
      print(status);
    } catch (e) {
      print("Error ------------------- ||||||||||||||||||||" + e.toString());
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
          title: new Text(
            name,
            style: new TextStyle(color: Colors.white),
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              // Navigator.pushNamed(context, '/viewdoctors');
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const MyViewDoctorsPage(title: '',)),);
              print("Hello");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ThirdScreen()),
              // );
            },
          ),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 50),
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.grey.shade200
                          : Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      messages[index].messageContent,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: te_message,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      String fid = "";
                      String toid = "";
                      String message = te_message.text.toString();

                      /////
                      try {
                        final pref = await SharedPreferences.getInstance();
                        String ip = pref.getString("url").toString();

                        String url = ip + "/ins_and_userinschat/";

                        var data = await http.post(Uri.parse(url), body: {
                          'message': message,
                          'from_id': pref.getString("lid").toString(),
                          'toid': widget.doc_id
                        });
                        var jsondata = json.decode(data.body);
                        String status = jsondata['status'];

                        te_message.text = "";

                        var arr = jsondata["data"];

                        setState(() {});

                        print("");
                      } catch (e) {
                        print("Error ------------------- " + e.toString());
                        //there is error during converting file image to base64 encoding.
                      }
                      ////

                      // print("Hiiiiii");
                      //
                      // setState(() {
                      //
                      //   List<ChatMessage> messages1= messages;
                      //   messages1.add(ChatMessage(messageContent: "Hello, Fadhil", messageType: "receiver"));
                      //   setState(() {
                      //
                      //     messages=messages1;
                      //   });
                      //
                      // });
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
