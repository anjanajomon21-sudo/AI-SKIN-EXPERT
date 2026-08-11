import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Upload',
      home: FileUploadScreen(),
    );
  }
}

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  File? _selectedFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickAndUploadFile() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadFile(File file) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');

    if (url == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Server URL not found in SharedPreferences')),
      );
      return;
    }

    final uri = Uri.parse('$url/prediction/');
    var request = http.MultipartRequest('POST', uri);

    // Attach file
    var multipartFile = await http.MultipartFile.fromPath('file', file.path);
    request.files.add(multipartFile);

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var respStr = await response.stream.bytesToString();
        var jsonResp = jsonDecode(respStr);

        String status = jsonResp['status'] ?? 'error';
        String disease = jsonResp['disease'] ?? 'Unknown';

        if (status == 'ok') {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Prediction Result'),
              content: Text('The AI predicts: $disease'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          _showError('Prediction failed');
        }
      } else {
        _showError('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      _showError('Upload failed: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: BackButton(color: Colors.white),
        title: Text('File Upload Example',
            style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_selectedFile != null) ...[
                // File preview
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedFile!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),

                // Upload Button with validation
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blueAccent,
                    elevation: 3,
                  ),
                  onPressed: () async {
                    if (_selectedFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                            Text("Please select a file before uploading.")),
                      );
                      return;
                    }
                    await uploadFile(_selectedFile!);
                  },
                  icon: const Icon(Icons.cloud_upload, color: Colors.white),
                  label: const Text(
                    'Upload File',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ] else ...[
                const Icon(Icons.insert_drive_file,
                    size: 80, color: Colors.grey),
                const SizedBox(height: 12),
                const Text(
                  'No file selected.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),

                // Pick File Button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 3,
                  ),
                  onPressed: () async {
                    await pickAndUploadFile();
                  },
                  icon: const Icon(Icons.folder_open, color: Colors.white),
                  label: const Text(
                    'Pick File',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
