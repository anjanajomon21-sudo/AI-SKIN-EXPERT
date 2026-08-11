// import 'dart:io';
//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:image_picker/image_picker.dart ';
//
// import 'package:permission_handler/permission_handler.dart';
// import 'loginnew.dart';
//
// void main() {
//   runApp(const MyMySignup());
// }
//
// class MyMySignup extends StatelessWidget {
//   const MyMySignup({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MySignup',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyMySignupPage(title: 'MySignup'),
//     );
//   }
// }
//
// class MyMySignupPage extends StatefulWidget {
//   const MyMySignupPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyMySignupPage> createState() => _MyMySignupPageState();
// }
//
// class _MyMySignupPageState extends State<MyMySignupPage> {
//   String gender = "Male";
//   File? uploadimage;
//   TextEditingController nameController = new TextEditingController();
//   TextEditingController dobController = new TextEditingController();
//   TextEditingController mobilenoControler = new TextEditingController();
//   TextEditingController emailController = new TextEditingController();
//   TextEditingController pinController = new TextEditingController();
//   TextEditingController passwordController = new TextEditingController();
//   TextEditingController confirmpasswordController = new TextEditingController();
//
//
//   // Future<void> chooseImage() async {
//   //   // final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
//   //   //set source: ImageSource.camera to get image from camera
//   //   setState(() {
//   //     // uploadimage = File(choosedimage!.path);
//   //   });
//   // }
//
//   @override
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               if (_selectedImage != null) ...{
//                 InkWell(
//                   child: Image.file(
//                     _selectedImage!,
//                     height: 400,
//                   ),
//                   radius: 399,
//                   onTap: _checkPermissionAndChooseImage,
//                 ),
//               } else ...{
//                 InkWell(
//                   onTap: _checkPermissionAndChooseImage,
//                   child: Column(
//                     children: [
//                       Image(
//                         image: NetworkImage(
//                           'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png',
//                         ),
//                         height: 200,
//                         width: 200,
//                       ),
//                       Text('Select Image', style: TextStyle(color: Colors.cyan))
//                     ],
//                   ),
//                 ),
//               },
//
//               // NAME
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextFormField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), label: Text("Name")),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return "Please enter your name";
//                     }
//                     if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
//                       return "Name can only contain letters and spaces";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//
//               // DOB
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextFormField(
//                   controller: dobController,
//                   readOnly: true,
//                   onTap: () => _selectDob(context),
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     label: Text("DoB"),
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return "Please select date of birth";
//                     }
//                     if (selectedDob == null) {
//                       return "Please select date of birth";
//                     }
//                     final today = DateTime.now();
//                     final age = today.year - selectedDob!.year -
//                         ((today.month < selectedDob!.month ||
//                             (today.month == selectedDob!.month &&
//                                 today.day < selectedDob!.day))
//                             ? 1
//                             : 0);
//                     if (age < 18) {
//                       return "You must be at least 18 years old";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//
//
//               // GENDER
//               RadioListTile(
//                 value: "Male",
//                 groupValue: gender,
//                 onChanged: (value) {
//                   setState(() {
//                     gender = value.toString();
//                   });
//                 },
//                 title: Text("Male"),
//               ),
//               RadioListTile(
//                 value: "Female",
//                 groupValue: gender,
//                 onChanged: (value) {
//                   setState(() {
//                     gender = value.toString();
//                   });
//                 },
//                 title: Text("Female"),
//               ),
//               RadioListTile(
//                 value: "Other",
//                 groupValue: gender,
//                 onChanged: (value) {
//                   setState(() {
//                     gender = value.toString();
//                   });
//                 },
//                 title: Text("Other"),
//               ),
//               if (gender == null)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Please select gender",
//                       style: TextStyle(color: Colors.red, fontSize: 12),
//                     ),
//                   ),
//                 ),
//
//               // EMAIL
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextFormField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), label: Text("Email")),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return "Please enter email";
//                     }
//                     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                       return "Enter a valid email";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//
//               // PHONE
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextFormField(
//                   controller: mobilenoControler,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), label: Text("Phone")),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return "Please enter phone number";
//                     }
//                     if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
//                       return "Enter a valid 10-digit phone number starting with 6, 7, 8, or 9";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//
//               // PIN
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextFormField(
//                   controller: pinController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), label: Text("Pin")),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return "Please enter pin";
//                     }
//                     if (!RegExp(r'^\d{6}$').hasMatch(value)) {
//                       return "Pin must be 6 digits";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//
//               // PASSWORD
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextFormField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(), label: Text("Password")),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return "Please enter password";
//                     }
//                     if (!RegExp(
//                         r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$')
//                         .hasMatch(value)) {
//                       return "Password must be 8+ chars, contain upper, lower, number & special char";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//
//               // CONFIRM PASSWORD
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: TextFormField(
//                   controller: confirmpasswordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       label: Text("Confirm Password")),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return "Please confirm password";
//                     }
//                     if (value != passwordController.text) {
//                       return "Passwords do not match";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//
//               // SUBMIT BUTTON
//               ElevatedButton(
//                 onPressed: () {
//                   if (_selectedImage == null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Please select an image")),
//                     );
//                     return;
//                   }
//                   if (gender == null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Please select gender")),
//                     );
//                     return;
//                   }
//                   if (_formKey.currentState!.validate()) {
//                     _send_data();
//                   }
//                 },
//                 child: Text("Signup"),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLoginPage(title: '',)));
//                 },
//                 child: Text("Login"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   void _send_data() async {
//     String uname = nameController.text;
//     String dob = dobController.text;
//     String pin = pinController.text;
//     String email = emailController.text;
//     String password = passwordController.text;
//     String confirmpassword = confirmpasswordController.text;
//     String mobileno = mobilenoControler.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//
//     final urls = Uri.parse('$url/user_signup/');
//     try {
//       final response = await http.post(urls, body: {
//         // "photo":photo,
//         "name": uname,
//         "gender": gender,
//         "photo": photo,
//         "dob": dob,
//         "pin": pin,
//         "email": email,
//         "mobileno": mobileno,
//         "Passsword": password,
//         "confirm": confirmpassword,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           Fluttertoast.showToast(msg: 'Registration Successfull');
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MyLoginPage(title: "Login"),
//               ));
//         } else if (status == 'mail') {
//           Fluttertoast.showToast(msg: 'Email Already in use');
//         } else  if (status == 'Username Existed'){
//           Fluttertoast.showToast(msg: 'Username already existed');
//         }
//         else if (status == 'num') {
//           Fluttertoast.showToast(msg: 'Number already in use');
//         } else if (password == confirmpassword) {
//           Fluttertoast.showToast(msg: 'Password miss match');
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   File? _selectedImage;
//   String? _encodedImage;
//
//   Future<void> _chooseAndUploadImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//         _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
//         photo = _encodedImage.toString();
//       });
//     }
//   }
//
//   Future<void> _checkPermissionAndChooseImage() async {
//     final PermissionStatus status = await Permission.mediaLibrary.request();
//     if (status.isGranted) {
//       _chooseAndUploadImage();
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Permission Denied'),
//           content: const Text(
//             'Please go to app settings and grant permission to choose an image.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   String photo = '';
//
//
//   DateTime? selectedDob;
//
//   Future<void> _selectDob(BuildContext context) async {
//     final DateTime today = DateTime.now();
//     final DateTime maxDate = DateTime(today.year - 18, today.month, today.day);
//
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: maxDate, // default to exactly 18 years ago
//       firstDate: DateTime(1900), // oldest allowed date
//       lastDate: maxDate, // limit to 18+ only
//     );
//
//     if (picked != null) {
//       setState(() {
//         selectedDob = picked;
//         dobController.text =
//         "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
//       });
//     }
//   }
//
//
// }

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'loginnew.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Up',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
      home: const SignupPage(title: 'Create Account'),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key, required this.title});

  final String title;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String gender = "Male";
  File? _selectedImage;
  String photo = '';
  DateTime? selectedDob;

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button and Title
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Profile Picture Section
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blue.shade200,
                                width: 3,
                              ),
                              color: Colors.grey.shade100,
                            ),
                            child: _selectedImage != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                                : Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _checkPermissionAndChooseImage,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade600,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.shade200,
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add Profile Picture',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      if (_selectedImage == null)
                        Text(
                          'Optional',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Full Name
                      _buildTextField(
                        controller: nameController,
                        label: 'Full Name',
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your name";
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
                            return "Name can only contain letters and spaces";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Date of Birth
                      TextFormField(
                        controller: dobController,
                        readOnly: true,
                        onTap: () => _selectDob(context),
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                          suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please select date of birth";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Gender Selection
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: _buildGenderChip('Male', Icons.male),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildGenderChip('Female', Icons.female),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildGenderChip('Other', Icons.transgender),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Email
                      _buildTextField(
                        controller: emailController,
                        label: 'Email Address',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter email";
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Phone Number
                      _buildTextField(
                        controller: phoneController,
                        label: 'Phone Number',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter phone number";
                          }
                          if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                            return "Enter a valid 10-digit phone number";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // PIN Code
                      _buildTextField(
                        controller: pinController,
                        label: 'PIN Code',
                        icon: Icons.location_on_outlined,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter PIN code";
                          }
                          if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                            return "PIN must be 6 digits";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Password
                      TextFormField(
                        controller: passwordController,
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter password";
                          }
                          if (!RegExp(
                              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$')
                              .hasMatch(value)) {
                            return "Password must be 8+ chars, contain upper, lower, number & special char";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 8),
                      _buildPasswordRequirements(),

                      const SizedBox(height: 16),

                      // Confirm Password
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: !_showConfirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showConfirmPassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _showConfirmPassword = !_showConfirmPassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please confirm password";
                          }
                          if (value != passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 32),

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSignup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                            shadowColor: Colors.blue.shade100,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                              : const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyLoginPage(title: ''),
                                ),
                              );
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.blue.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Terms and Conditions
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'By creating an account, you agree to our Terms of Service and Privacy Policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildGenderChip(String genderText, IconData icon) {
    bool isSelected = gender == genderText;
    return GestureDetector(
      onTap: () {
        setState(() {
          gender = genderText;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue.shade300 : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue.shade600 : Colors.grey.shade600,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              genderText,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.blue.shade800 : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password must contain:',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        _buildRequirementItem('At least 8 characters'),
        _buildRequirementItem('Uppercase letter (A-Z)'),
        _buildRequirementItem('Lowercase letter (a-z)'),
        _buildRequirementItem('Number (0-9)'),
        _buildRequirementItem('Special character (!@#\$%^&*)'),
      ],
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 4,
            color: Colors.grey.shade400,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  // Image Picker Methods
  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        photo = base64Encode(_selectedImage!.readAsBytesSync());
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.photos.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
            'Please grant photo library permission to choose a profile picture.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => openAppSettings(),
              child: const Text('Settings'),
            ),
          ],
        ),
      );
    }
  }

  // Date Picker
  Future<void> _selectDob(BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime maxDate = DateTime(today.year - 18, today.month, today.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: maxDate,
      firstDate: DateTime(1900),
      lastDate: maxDate,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDob = picked;
        dobController.text =
        "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      });
    }
  }

  // Signup Handler
  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      if (gender == null) {
        Fluttertoast.showToast(msg: 'Please select gender');
        return;
      }

      setState(() {
        _isLoading = true;
      });

      await _sendData();

      setState(() {
        _isLoading = false;
      });
    }
  }

  // API Call
  Future<void> _sendData() async {
    String uname = nameController.text;
    String dob = dobController.text;
    String pin = pinController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmpassword = confirmPasswordController.text;
    String mobileno = phoneController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_signup/');

    try {
      final response = await http.post(urls, body: {
        "name": uname,
        "gender": gender,
        "photo": photo,
        "dob": dob,
        "pin": pin,
        "email": email,
        "mobileno": mobileno,
        "Passsword": password,
        "confirm": confirmpassword,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String status = data['status'];

        if (status == 'ok') {
          Fluttertoast.showToast(
            msg: 'Registration Successful',
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyLoginPage(title: "Login"),
            ),
          );
        } else if (status == 'mail') {
          Fluttertoast.showToast(msg: 'Email already in use');
        } else if (status == 'Username Existed') {
          Fluttertoast.showToast(msg: 'Username already exists');
        } else if (status == 'num') {
          Fluttertoast.showToast(msg: 'Phone number already in use');
        } else {
          Fluttertoast.showToast(msg: 'Registration failed');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Connection error: ${e.toString()}');
    }
  }
}
