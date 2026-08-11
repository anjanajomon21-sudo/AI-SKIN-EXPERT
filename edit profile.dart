

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart ';

import 'package:permission_handler/permission_handler.dart';

import 'view_prof_new (1).dart';


void main() {
  runApp(const MyEdit());
}

class MyEdit extends StatelessWidget {
  const MyEdit({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Edit Profile',
      // theme: ThemeData(
      //
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: const MyEditPage(title: 'Edit Profile'),
    );
  }
}

class MyEditPage extends StatefulWidget {
  const MyEditPage({super.key, required this.title});

  final String title;

  @override
  State<MyEditPage> createState() => _MyEditPageState();
}

class _MyEditPageState extends State<MyEditPage> {

  _MyEditPageState()
  {
    _get_data();
  }




  String name='name';
  String email='email';
  String phone='phone';

  String age='age';
  // String gender='gender';
  String image='image';
  String pin='pin';



  String gender = "Male";

  TextEditingController nameController= new TextEditingController();
  TextEditingController dobController= new TextEditingController();
  TextEditingController emailController= new TextEditingController();
  TextEditingController phoneController= new TextEditingController();
  TextEditingController placeController= new TextEditingController();
  TextEditingController postController= new TextEditingController();
  TextEditingController pinController= new TextEditingController();
  TextEditingController districtController= new TextEditingController();
  String photos='';
  final _formKey = GlobalKey<FormState>();


  void _get_data() async{




    SharedPreferences sh=await SharedPreferences.getInstance();
    String url=sh.getString('url').toString();
    String lid=sh.getString('lid').toString();
    final urls=Uri.parse(url+"/user_viewprofile/");
    try{
      final response=await http.post(urls,body:{
        'lid':lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Success');


          setState(() {
            email=jsonDecode(response.body)['Email'];
            name=jsonDecode(response.body)['Name'];
            phone=jsonDecode(response.body)['Mobileno'];
            gender=jsonDecode(response.body)['Gender'];
            age=jsonDecode(response.body)['Dob'];
            pin=jsonDecode(response.body)['Pin'].toString();

            image=sh.getString('img_url').toString()+jsonDecode(response.body)['Photo'];





            nameController.text=name;
          dobController.text=age;
          emailController.text=email;
          phoneController.text=phone;

          pinController.text=pin;

            gender=gender;
            photos=image;
          });







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

  @override
  Widget build(BuildContext context) {




    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
    leading: BackButton(
    color: Colors.white, // Change arrow color
    onPressed: () {
    Navigator.pop(context); // Go back to previous screen
    }, ),
          title: Text("Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _checkPermissionAndChooseImage,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : NetworkImage(photos) as ImageProvider,
                    child: _selectedImage == null
                        ? const Icon(Icons.camera_alt, size: 40, color: Colors.cyan)
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Tap image to select",
                  style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),

                // NAME
                _buildTextFormField(
                  nameController,
                  "Name",
                      (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your name";
                    }
                    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
                      return "Name can only contain letters and spaces";
                    }
                    return null;
                  },
                ),

                // DOB (Calendar Picker)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: dobController,
                    readOnly: true,
                    onTap: () => _selectDob(context),
                    decoration: InputDecoration(
                      labelText: "Date of Birth",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please select your date of birth";
                      }
                      if (selectedDob == null) {
                        return "Please select your date of birth";
                      }
                      final today = DateTime.now();
                      final age = today.year - selectedDob!.year -
                          ((today.month < selectedDob!.month ||
                              (today.month == selectedDob!.month &&
                                  today.day < selectedDob!.day))
                              ? 1
                              : 0);
                      if (age < 18) {
                        return "You must be at least 18 years old";
                      }
                      return null;
                    },
                  ),
                ),

                _buildGenderSelector(),

                // EMAIL
                _buildTextFormField(
                  emailController,
                  "Email",
                      (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your email";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),

                // PHONE
                _buildTextFormField(
                  phoneController,
                  "Phone",
                      (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter phone number";
                    }
                    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim())) {
                      return "Enter a valid 10-digit number starting with 6, 7, 8, or 9";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),

                // PIN
                _buildTextFormField(
                  pinController,
                  "PIN Code",
                      (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter PIN code";
                    }
                    if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
                      return "PIN code must be 6 digits";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _send_data();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      "Confirm Edit",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
  void _send_data() async{





    String uname=nameController.text;
    String dob=dobController.text;
    String email=emailController.text;
    String phone=phoneController.text;

    String pin=pinController.text;


    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_editprofile/');
    try {

      final response = await http.post(urls, body: {
        "name":uname,
        "gender":gender,
        "photo":photo,
        "dob":dob,
        "pin":pin,
        "email":email,
        "mobileno":phone,
        'lid':lid,

      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Updated Successfully');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => userProfile_new1(title: "Profile"),));
        }

        else if(status == 'num'){
          Fluttertoast.showToast(msg: 'Number already in use');
        }

        else if(status == 'mail'){
          Fluttertoast.showToast(msg: 'Email already in use');
        }

        else {
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
  File? _selectedImage;
  String? _encodedImage;
  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String photo = '';


  Widget _buildTextFormField(
      TextEditingController controller,
      String label,
      String? Function(String?) validator, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }


  Widget _buildGenderSelector() {
    return Column(
      children: [
        RadioListTile(
          value: "Male",
          groupValue: gender,
          onChanged: (value) => setState(() => gender = value.toString()),
          title: const Text("Male"),
        ),
        RadioListTile(
          value: "Female",
          groupValue: gender,
          onChanged: (value) => setState(() => gender = value.toString()),
          title: const Text("Female"),
        ),
        RadioListTile(
          value: "Other",
          groupValue: gender,
          onChanged: (value) => setState(() => gender = value.toString()),
          title: const Text("Other"),
        ),
      ],
    );
  }

  DateTime? selectedDob;

  Future<void> _selectDob(BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime maxDate = DateTime(today.year - 18, today.month, today.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: maxDate,
      firstDate: DateTime(1900),
      lastDate: maxDate, // restrict to 18+ only
    );

    if (picked != null) {
      setState(() {
        selectedDob = picked;
        dobController.text =
        "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      });
    }
  }



}
