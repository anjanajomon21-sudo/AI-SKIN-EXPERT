import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final oldpasswordController = TextEditingController();
  final newpasswordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        title: const Text("Change Password",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.lock_outline, size: 60, color: Colors.blue),
                      const SizedBox(height: 10),
                      const Text(
                        "Update Your Password",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),

                      _buildPasswordField(oldpasswordController, "Old Password"),
                      const SizedBox(height: 12),
                      _buildPasswordField(newpasswordController, "New Password"),
                      const SizedBox(height: 12),
                      _buildPasswordField(confirmpasswordController, "Confirm Password"),

                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _changePassword,
                          icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                          label: const Text(
                            "Change Password",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

    );
  }


  Widget _buildPasswordField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $label";
        }

        // For New Password & Confirm Password, check strength
        if (label == "New Password") {
          final passwordRegEx = RegExp(
              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
          if (!passwordRegEx.hasMatch(value)) {
            return "Password must be at least 8 characters,\ninclude uppercase, lowercase, number, and special character";
          }
        }

        if (label == "Confirm Password" && value != newpasswordController.text) {
          return "Passwords do not match";
        }

        return null;
      },
    );
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      String oldp = oldpasswordController.text.trim();
      String newp = newpasswordController.text.trim();
      String confp = confirmpasswordController.text.trim();

      if (oldp.isEmpty || newp.isEmpty || confp.isEmpty) {
        Fluttertoast.showToast(msg: "Please fill all fields");
        return;
      }
      if (newp != confp) {
        Fluttertoast.showToast(msg: "New passwords do not match");
        return;
      }

      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();

      final urls = Uri.parse('$url/user_changepassword/');
      try {
        final response = await http.post(urls, body: {
          'lid': lid,
          'oldpassword': oldp,
          'newpassword': newp,
          'confirmpassword': confp,
        });

        if (response.statusCode == 200) {
          String status = jsonDecode(response.body)['status'];
          if (status == 'ok') {
            Fluttertoast.showToast(msg: 'Password Changed Successfully');
            Navigator.pop(context);
          } else {
            Fluttertoast.showToast(msg: 'Incorrect Old Password');
          }
        } else {
          Fluttertoast.showToast(msg: 'Network Error');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

}
