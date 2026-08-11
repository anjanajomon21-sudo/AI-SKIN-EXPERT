import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewMeetingRequestsPage extends StatefulWidget {
  const ViewMeetingRequestsPage({Key? key}) : super(key: key);

  @override
  State<ViewMeetingRequestsPage> createState() => _ViewMeetingRequestsPageState();
}

class _ViewMeetingRequestsPageState extends State<ViewMeetingRequestsPage> {
  List<Map<String, dynamic>> requests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String userId = sh.getString('lid').toString();
      String url = '$urls/user_view_meeting_requests/';

      var response = await http.post(Uri.parse(url), body: {'user_id': userId});
      var jsondata = json.decode(response.body);

      if (jsondata['status'] == 'ok') {
        setState(() {
          requests = List<Map<String, dynamic>>.from(jsondata['data']);
          isLoading = false;
        });
      } else {
        Fluttertoast.showToast(msg: jsondata['message'] ?? 'Failed to load requests');
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'accepted':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Fluttertoast.showToast(msg: 'Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Meeting Requests",
          style: TextStyle(color: Colors.white),
        ),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : requests.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.video_call, size: 60, color: Colors.grey.shade400),
            const SizedBox(height: 20),
            const Text(
              'No Meeting Requests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Date Row
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18, color: Colors.blue),
                      const SizedBox(width: 12),
                      const Text(
                        'Meeting Date:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        request['date'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      const Icon(Icons.punch_clock, size: 18, color: Colors.blue),
                      const SizedBox(width: 12),
                      const Text(
                        'Meeting Time:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        request['time'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Meeting Link Row
                  Row(
                    children: [
                      const Icon(Icons.link, size: 18, color: Colors.blue),
                      const SizedBox(width: 12),
                      const Text(
                        'Link:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: request['meeting_link'].isNotEmpty
                            ? GestureDetector(
                          onTap: () => _launchURL(request['meeting_link']),
                          child: Text(
                            request['meeting_link'],
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                            : const Text(
                          'No link available',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),

                  // Status indicator
                  if (request['meeting_link'].isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                           
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
    );
  }
}