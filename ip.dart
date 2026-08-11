// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // // import 'loginnew.dart';
// // //
// // //
// // // void main(){
// // //   runApp(const MyApp());
// // // }
// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       title: 'Flutter Demo',
// // //       theme: ThemeData(
// // //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// // //         useMaterial3: true,
// // //       ),
// // //       home: const MyIpPage(title: 'IP Page'),
// // //     );
// // //
// // //   }
// // // }
// // // class MyIpPage extends StatefulWidget {
// // //   const MyIpPage({super.key,required this.title});
// // //
// // //   final String title;
// // //
// // //   @override
// // //   State<MyIpPage> createState() => _MyIpPageState();
// // // }
// // //
// // // class _MyIpPageState extends
// // // State<MyIpPage> {
// // //
// // //   TextEditingController ipConttroller = TextEditingController();
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         leading: BackButton(color: Colors.white,),
// // //         backgroundColor: Colors.blue,
// // //         title: Text("IP page",style: TextStyle(color: Colors.white),),
// // //       ),
// // //
// // //       body: Container(
// // //         child: Center(
// // //           child: Column(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               children: <Widget>[
// // //                 Padding(padding: EdgeInsets.all(5),
// // //                   child: TextFormField(
// // //                     validator: (value) => Validateip(value!),
// // //
// // //                     controller: ipConttroller,
// // //                     decoration: InputDecoration( fillColor: Colors.grey.shade100,
// // //                         filled: true,
// // //                         hintText: 'ip address',border:
// // //
// // //                         OutlineInputBorder(), labelText:
// // //                         'Ip Address'),
// // //                   ),
// // //                 ),
// // //                 ElevatedButton(style: ElevatedButton.styleFrom(
// // //                   backgroundColor: Colors.blue,
// // //
// // //                   foregroundColor: Colors.white,
// // //                 ),
// // //                     onPressed: () {
// // //                       senddata();
// // //                     }, child: Text('Connect')
// // //                 )
// // //               ]
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //     // TODO:Impliment build
// // //     //  throw UnimplementedError();
// // //
// // //
// // //
// // //   }
// // //
// // //   void senddata() async {
// // //     String ip = ipConttroller.text;
// // //     SharedPreferences sh = await SharedPreferences.getInstance();
// // //     sh.setString("url", "http://" + ip + ":8000/myapp");
// // //     sh.setString("img_url", "http://" + ip + ":8000");
// // //
// // //     Navigator.push(context, MaterialPageRoute(
// // //       builder: (context) => MyLoginPage(title: '',),));
// // //
// // //   }
// // //   String? Validateip(String value){
// // //     if(value.isEmpty){
// // //       return 'please enter a IP';
// // //     }
// // //     return null;
// // //   }
// // //
// // // }
// // //
// // //
// // //
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'loginnew.dart';
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(
// //           seedColor: Colors.blue,
// //           brightness: Brightness.light,
// //         ),
// //         useMaterial3: true,
// //         inputDecorationTheme: InputDecorationTheme(
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(12),
// //             borderSide: const BorderSide(color: Colors.grey),
// //           ),
// //           focusedBorder: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(12),
// //             borderSide: const BorderSide(color: Colors.blue, width: 2),
// //           ),
// //           filled: true,
// //           fillColor: Colors.grey.shade50,
// //           contentPadding: const EdgeInsets.symmetric(
// //             horizontal: 16,
// //             vertical: 14,
// //           ),
// //         ),
// //       ),
// //       home: const MyIpPage(title: 'IP Configuration'),
// //     );
// //   }
// // }
// //
// // class MyIpPage extends StatefulWidget {
// //   const MyIpPage({super.key, required this.title});
// //
// //   final String title;
// //
// //   @override
// //   State<MyIpPage> createState() => _MyIpPageState();
// // }
// //
// // class _MyIpPageState extends State<MyIpPage> {
// //   TextEditingController ipController = TextEditingController();
// //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// //   bool _isConnecting = false;
// //   bool _showExample = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadSavedIp();
// //   }
// //
// //   void _loadSavedIp() async {
// //     SharedPreferences sh = await SharedPreferences.getInstance();
// //     String? savedUrl = sh.getString("url");
// //     if (savedUrl != null) {
// //       // Extract IP from saved URL
// //       final uri = Uri.parse(savedUrl);
// //       if (uri.host.isNotEmpty) {
// //         ipController.text = uri.host;
// //       }
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey.shade50,
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.all(24.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: <Widget>[
// //                 // Back button
// //                 IconButton(
// //                   onPressed: () => Navigator.maybePop(context),
// //                   icon: Container(
// //                     padding: const EdgeInsets.all(8),
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(12),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.grey.withOpacity(0.1),
// //                           blurRadius: 10,
// //                           spreadRadius: 1,
// //                         ),
// //                       ],
// //                     ),
// //                     child: const Icon(
// //                       Icons.arrow_back_ios_new,
// //                       size: 20,
// //                       color: Colors.blue,
// //                     ),
// //                   ),
// //                 ),
// //
// //                 const SizedBox(height: 40),
// //
// //                 // Header Section
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Container(
// //                       width: 60,
// //                       height: 60,
// //                       decoration: BoxDecoration(
// //                         color: Colors.blue.withOpacity(0.1),
// //                         borderRadius: BorderRadius.circular(16),
// //                       ),
// //                       child: const Icon(
// //                         Icons.dns_outlined,
// //                         size: 32,
// //                         color: Colors.blue,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 24),
// //                     Text(
// //                       'Server Configuration',
// //                       style: Theme.of(context).textTheme.headlineMedium?.copyWith(
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.grey.shade900,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     Text(
// //                       'Enter your server IP address to connect',
// //                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
// //                         color: Colors.grey.shade600,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //
// //                 const SizedBox(height: 48),
// //
// //                 // Form Section
// //                 Form(
// //                   key: _formKey,
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         'Server IP Address',
// //                         style: TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.w500,
// //                           color: Colors.grey.shade700,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 12),
// //                       TextFormField(
// //                         controller: ipController,
// //                         validator: validateIp,
// //                         decoration: InputDecoration(
// //                           hintText: 'e.g., 192.168.1.100',
// //                           prefixIcon: const Icon(
// //                             Icons.link,
// //                             color: Colors.grey,
// //                           ),
// //                           suffixIcon: IconButton(
// //                             icon: Icon(
// //                               _showExample ? Icons.visibility_off : Icons.visibility,
// //                               color: Colors.grey,
// //                             ),
// //                             onPressed: () {
// //                               setState(() {
// //                                 _showExample = !_showExample;
// //                                 if (_showExample) {
// //                                   ipController.text = '192.168.1.100';
// //                                 }
// //                               });
// //                             },
// //                           ),
// //                         ),
// //                         keyboardType: TextInputType.url,
// //                       ),
// //
// //                       const SizedBox(height: 16),
// //
// //                       // Info Card
// //                       Container(
// //                         padding: const EdgeInsets.all(16),
// //                         decoration: BoxDecoration(
// //                           color: Colors.blue.withOpacity(0.05),
// //                           borderRadius: BorderRadius.circular(12),
// //                           border: Border.all(color: Colors.blue.withOpacity(0.1)),
// //                         ),
// //                         child: Row(
// //                           children: [
// //                             Icon(
// //                               Icons.info_outline,
// //                               color: Colors.blue.shade600,
// //                               size: 20,
// //                             ),
// //                             const SizedBox(width: 12),
// //                             Expanded(
// //                               child: Text(
// //                                 'Make sure your server is running on port 8000',
// //                                 style: TextStyle(
// //                                   color: Colors.blue.shade800,
// //                                   fontSize: 14,
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //
// //                       const SizedBox(height: 32),
// //
// //                       // Connect Button
// //                       SizedBox(
// //                         width: double.infinity,
// //                         child: ElevatedButton(
// //                           onPressed: _isConnecting ? null : _connectToServer,
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: Colors.blue,
// //                             foregroundColor: Colors.white,
// //                             padding: const EdgeInsets.symmetric(vertical: 16),
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(12),
// //                             ),
// //                             elevation: 0,
// //                           ),
// //                           child: _isConnecting
// //                               ? const Row(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               SizedBox(
// //                                 width: 20,
// //                                 height: 20,
// //                                 child: CircularProgressIndicator(
// //                                   strokeWidth: 2,
// //                                   color: Colors.white,
// //                                 ),
// //                               ),
// //                               SizedBox(width: 12),
// //                               Text('Connecting...'),
// //                             ],
// //                           )
// //                               : const Row(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               Icon(Icons.link, size: 20),
// //                               SizedBox(width: 8),
// //                               Text(
// //                                 'Connect to Server',
// //                                 style: TextStyle(
// //                                   fontSize: 16,
// //                                   fontWeight: FontWeight.w600,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //
// //                       const SizedBox(height: 16),
// //
// //                       // Quick Help Section
// //                       ExpansionTile(
// //                         tilePadding: EdgeInsets.zero,
// //                         collapsedIconColor: Colors.grey,
// //                         iconColor: Colors.blue,
// //                         title: Text(
// //                           'Need help?',
// //                           style: TextStyle(
// //                             color: Colors.grey.shade700,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                         children: [
// //                           Padding(
// //                             padding: const EdgeInsets.only(bottom: 16),
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 _buildHelpItem(
// //                                   icon: Icons.computer,
// //                                   title: 'Local Server',
// //                                   description: 'Use 127.0.0.1 for localhost',
// //                                 ),
// //                                 const SizedBox(height: 12),
// //                                 _buildHelpItem(
// //                                   icon: Icons.wifi,
// //                                   title: 'Network Server',
// //                                   description: 'Use your computer\'s IP address',
// //                                 ),
// //                                 const SizedBox(height: 12),
// //                                 _buildHelpItem(
// //                                   icon: Icons.security,
// //                                   title: 'Port Information',
// //                                   description: 'Ensure port 8000 is open in firewall',
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //
// //                 const SizedBox(height: 32),
// //
// //                 // Footer
// //                 Container(
// //                   padding: const EdgeInsets.all(16),
// //                   decoration: BoxDecoration(
// //                     color: Colors.grey.shade100,
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   child: Row(
// //                     children: [
// //                       Icon(
// //                         Icons.lightbulb_outline,
// //                         color: Colors.amber.shade700,
// //                         size: 20,
// //                       ),
// //                       const SizedBox(width: 12),
// //                       Expanded(
// //                         child: Text(
// //                           'Tip: You can find your IP address in network settings',
// //                           style: TextStyle(
// //                             color: Colors.grey.shade700,
// //                             fontSize: 14,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildHelpItem({
// //     required IconData icon,
// //     required String title,
// //     required String description,
// //   }) {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Icon(
// //           icon,
// //           size: 18,
// //           color: Colors.blue,
// //         ),
// //         const SizedBox(width: 12),
// //         Expanded(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 title,
// //                 style: const TextStyle(
// //                   fontWeight: FontWeight.w500,
// //                   fontSize: 14,
// //                 ),
// //               ),
// //               Text(
// //                 description,
// //                 style: TextStyle(
// //                   fontSize: 13,
// //                   color: Colors.grey.shade600,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   void _connectToServer() async {
// //     if (!_formKey.currentState!.validate()) {
// //       return;
// //     }
// //
// //     setState(() {
// //       _isConnecting = true;
// //     });
// //
// //     await Future.delayed(const Duration(milliseconds: 1500));
// //
// //     try {
// //       String ip = ipController.text.trim();
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //
// //       // Remove http:// if already present
// //       ip = ip.replaceAll('http://', '').replaceAll('https://', '');
// //
// //       sh.setString("url", "http://$ip:8000/myapp");
// //       sh.setString("img_url", "http://$ip:8000");
// //
// //       // Show success message
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: const Row(
// //             children: [
// //               Icon(Icons.check_circle, color: Colors.white, size: 20),
// //               SizedBox(width: 8),
// //               Text('Successfully connected to server!'),
// //             ],
// //           ),
// //           backgroundColor: Colors.green,
// //           behavior: SnackBarBehavior.floating,
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(8),
// //           ),
// //         ),
// //       );
// //
// //       // Navigate after a short delay
// //       await Future.delayed(const Duration(milliseconds: 500));
// //
// //       if (mounted) {
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => MyLoginPage(title: ''),
// //           ),
// //         );
// //       }
// //     } catch (e) {
// //       // Show error message
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: const Row(
// //             children: [
// //               Icon(Icons.error_outline, color: Colors.white, size: 20),
// //               SizedBox(width: 8),
// //               Text('Failed to connect. Please check the IP address.'),
// //             ],
// //           ),
// //           backgroundColor: Colors.red,
// //           behavior: SnackBarBehavior.floating,
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(8),
// //           ),
// //         ),
// //       );
// //     } finally {
// //       if (mounted) {
// //         setState(() {
// //           _isConnecting = false;
// //         });
// //       }
// //     }
// //   }
// //
// //   String? validateIp(String? value) {
// //     if (value == null || value.isEmpty) {
// //       return 'Please enter an IP address';
// //     }
// //
// //     // Basic IP validation regex
// //     final ipRegex = RegExp(
// //         r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
// //
// //     // Also accept localhost
// //     if (value != 'localhost' && !ipRegex.hasMatch(value)) {
// //       return 'Please enter a valid IP address';
// //     }
// //
// //     return null;
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'loginnew.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Ai Skin',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.blue,
//           brightness: Brightness.light,
//         ),
//         useMaterial3: true,
//         fontFamily: 'Inter',
//       ),
//       home: const MyIpPage(title: 'IP Configuration'),
//     );
//   }
// }
//
// class MyIpPage extends StatefulWidget {
//   const MyIpPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyIpPage> createState() => _MyIpPageState();
// }
//
// class _MyIpPageState extends State<MyIpPage> {
//   TextEditingController ipController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool _isConnecting = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSavedIp();
//   }
//
//   void _loadSavedIp() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? savedUrl = sh.getString("url");
//     if (savedUrl != null) {
//       final uri = Uri.parse(savedUrl);
//       if (uri.host.isNotEmpty) {
//         ipController.text = uri.host;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 // Top Section - App Name
//                 Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     Text(
//                       'Ai Skin',
//                       style: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.w800,
//                         color: Colors.blue.shade700,
//                         letterSpacing: -0.5,
//                       ),
//                     ),
//                     const SizedBox(height: 60),
//                   ],
//                 ),
//
//                 // Center Section - Welcome Message and Form
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Welcome Text
//                       Text(
//                         'Welcome!',
//                         style: TextStyle(
//                           fontSize: 36,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.grey.shade900,
//                           letterSpacing: -1.0,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Connect to your server to continue',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                       const SizedBox(height: 60),
//
//                       // IP Input Form
//                       Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(16),
//                                 border: Border.all(
//                                   color: Colors.grey.shade300,
//                                   width: 1.5,
//                                 ),
//                               ),
//                               child: TextFormField(
//                                 controller: ipController,
//                                 validator: validateIp,
//                                 decoration: InputDecoration(
//                                   hintText: 'Enter server IP address',
//                                   hintStyle: TextStyle(
//                                     color: Colors.grey.shade500,
//                                   ),
//                                   border: InputBorder.none,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 20,
//                                     vertical: 18,
//                                   ),
//                                   prefixIcon: Icon(
//                                     Icons.dns_outlined,
//                                     color: Colors.blue.shade600,
//                                   ),
//                                   suffixIcon: ipController.text.isNotEmpty
//                                       ? IconButton(
//                                     icon: Icon(
//                                       Icons.clear,
//                                       color: Colors.grey.shade500,
//                                     ),
//                                     onPressed: () {
//                                       ipController.clear();
//                                       setState(() {});
//                                     },
//                                   )
//                                       : null,
//                                 ),
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.grey.shade800,
//                                 ),
//                                 keyboardType: TextInputType.url,
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             if (ipController.text.isNotEmpty &&
//                                 ipController.text != 'localhost' &&
//                                 !_isValidIp(ipController.text))
//                               Text(
//                                 'Please enter a valid IP address like 192.168.1.100',
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.red.shade600,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//
//                       // Connect Button
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _isConnecting ? null : _connectToServer,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue.shade600,
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 18),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             elevation: 2,
//                             shadowColor: Colors.blue.shade100,
//                           ),
//                           child: _isConnecting
//                               ? const SizedBox(
//                             width: 24,
//                             height: 24,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2.5,
//                               color: Colors.white,
//                             ),
//                           )
//                               : Text(
//                             'Connect',
//                             style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       // Alternative Options
//                       const SizedBox(height: 24),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Divider(
//                               color: Colors.grey.shade300,
//                               thickness: 1,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: Text(
//                               'or use',
//                               style: TextStyle(
//                                 color: Colors.grey.shade500,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Divider(
//                               color: Colors.grey.shade300,
//                               thickness: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 24),
//
//                       // Predefined IP Buttons
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           _buildQuickIpButton('127.0.0.1', 'Local'),
//                           const SizedBox(width: 12),
//                           _buildQuickIpButton('192.168.1.1', 'Router'),
//                           const SizedBox(width: 12),
//                           _buildQuickIpButton('10.0.0.1', 'Network'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Bottom Section - Additional Options
//                 Column(
//                   children: [
//                     // Help Text
//                     GestureDetector(
//                       onTap: () {
//                         _showHelpDialog(context);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade50,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: Colors.grey.shade200,
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.help_outline,
//                               size: 18,
//                               color: Colors.blue.shade600,
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               'Need help finding your IP?',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.blue.shade600,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//
//                     // Footer
//                     Text(
//                       'iwise.com',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey.shade500,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQuickIpButton(String ip, String label) {
//     return OutlinedButton(
//       onPressed: () {
//         ipController.text = ip;
//         setState(() {});
//       },
//       style: OutlinedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         side: BorderSide(
//           color: Colors.grey.shade300,
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey.shade600,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             ip,
//             style: TextStyle(
//               fontSize: 11,
//               color: Colors.grey.shade800,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showHelpDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(
//           'How to find your server IP',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Colors.grey.shade900,
//           ),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHelpStep(
//               '1. On Windows',
//               'Open Command Prompt and type: ipconfig\nLook for "IPv4 Address"',
//             ),
//             const SizedBox(height: 16),
//             _buildHelpStep(
//               '2. On Mac/Linux',
//               'Open Terminal and type: ifconfig\nLook for "inet" address',
//             ),
//             const SizedBox(height: 16),
//             _buildHelpStep(
//               '3. Server IP',
//               'Your server should be running on the same network\nPort: 8000',
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(
//               'Got it',
//               style: TextStyle(
//                 color: Colors.blue.shade600,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHelpStep(String title, String description) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Colors.grey.shade800,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           description,
//           style: TextStyle(
//             color: Colors.grey.shade600,
//             fontSize: 14,
//           ),
//         ),
//       ],
//     );
//   }
//
//   bool _isValidIp(String ip) {
//     final ipRegex = RegExp(
//         r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
//     return ip == 'localhost' || ipRegex.hasMatch(ip);
//   }
//
//   void _connectToServer() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     setState(() {
//       _isConnecting = true;
//     });
//
//     await Future.delayed(const Duration(milliseconds: 1200));
//
//     try {
//       String ip = ipController.text.trim();
//       SharedPreferences sh = await SharedPreferences.getInstance();
//
//       ip = ip.replaceAll('http://', '').replaceAll('https://', '');
//
//       sh.setString("url", "http://$ip:8000/myapp");
//       sh.setString("img_url", "http://$ip:8000");
//
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => MyLoginPage(title: ''),
//           ),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Connection failed: ${e.toString()}',
//               style: const TextStyle(color: Colors.white),
//             ),
//             backgroundColor: Colors.red.shade600,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isConnecting = false;
//         });
//       }
//     }
//   }
//
//   String? validateIp(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter server IP address';
//     }
//
//     if (!_isValidIp(value)) {
//       return 'Please enter a valid IP address';
//     }
//
//     return null;
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      title: 'DermaAI - Skin Disease Detection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8E2DE2),
          brightness: Brightness.light,
          primary: const Color(0xFF8E2DE2),
          secondary: const Color(0xFF4A00E0),
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const MyIpPage(title: 'Server Connection'),
    );
  }
}

class MyIpPage extends StatefulWidget {
  const MyIpPage({super.key, required this.title});

  final String title;

  @override
  State<MyIpPage> createState() => _MyIpPageState();
}

class _MyIpPageState extends State<MyIpPage> with SingleTickerProviderStateMixin {
  TextEditingController ipController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isConnecting = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _loadSavedIp();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadSavedIp() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? savedUrl = sh.getString("url");
    if (savedUrl != null) {
      final uri = Uri.parse(savedUrl);
      if (uri.host.isNotEmpty) {
        ipController.text = uri.host;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF8E2DE2),
              const Color(0xFF4A00E0),
              const Color(0xFF23074D),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Top Section - Logo and App Name
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        // Animated Logo
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.white, Color(0xFFE0E0E0)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(
                              'assets/logo.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.white,
                                  child: const Icon(
                                    Icons.health_and_safety,
                                    size: 50,
                                    color: Color(0xFF8E2DE2),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'DermaAI',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 1.5,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            'Skin Disease Detection',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Center Section - Welcome Message and Form
                  Expanded(
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Welcome Text
                            Text(
                              'Connect to Server',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withOpacity(0.95),
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Enter your server IP address to access\nthe skin disease detection model',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.7),
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 50),

                            // IP Input Form
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 20,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: TextFormField(
                                      controller: ipController,
                                      validator: validateIp,
                                      decoration: InputDecoration(
                                        hintText: 'Enter server IP',
                                        hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(0.15),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 18,
                                        ),
                                        prefixIcon: Icon(
                                          Icons.dns_outlined,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                        suffixIcon: ipController.text.isNotEmpty
                                            ? IconButton(
                                          icon: Icon(
                                            Icons.clear,
                                            color: Colors.white.withOpacity(0.8),
                                          ),
                                          onPressed: () {
                                            ipController.clear();
                                            setState(() {});
                                          },
                                        )
                                            : null,
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                      keyboardType: TextInputType.url,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  if (ipController.text.isNotEmpty &&
                                      ipController.text != 'localhost' &&
                                      !_isValidIp(ipController.text))
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.red.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.red.shade300,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              'Please enter a valid IP address (e.g., 192.168.1.100)',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.red.shade200,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Connect Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isConnecting ? null : _connectToServer,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF8E2DE2),
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 5,
                                  shadowColor: Colors.white.withOpacity(0.3),
                                ),
                                child: _isConnecting
                                    ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          const Color(0xFF8E2DE2),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Connecting to Server...',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                                    : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.link, size: 22),
                                    SizedBox(width: 8),
                                    Text(
                                      'Connect to DermaAI Server',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 25),

                            // Quick IP Buttons

                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom Section - Additional Options
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        // Help Button
                        GestureDetector(
                          onTap: () {
                            _showHelpDialog(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.help_outline,
                                  color: Colors.white.withOpacity(0.9),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),

                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Footer
                        Text(
                          'Powered by Deep Learning AI',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '© 2024 DermaAI - Skin Disease Detection System',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.3),
                            fontWeight: FontWeight.w400,
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
      ),
    );
  }

  Widget _buildQuickIpButton(String ip, String label) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          ipController.text = ip;
          setState(() {});
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                ip,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.help,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Server Connection Help',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildHelpStep(
                '1. Windows',
                'Open Command Prompt and type: ipconfig\nLook for "IPv4 Address" (e.g., 192.168.1.100)',
                Icons.computer,
              ),
              const SizedBox(height: 16),
              _buildHelpStep(
                '2. Mac/Linux',
                'Open Terminal and type: ifconfig\nLook for "inet" address under your network adapter',
                Icons.terminal,
              ),
              const SizedBox(height: 16),
              _buildHelpStep(
                '3. Server Requirements',
                '• Python Django server must be running\n• Port 8000 should be accessible\n• Same network connection required',
                Icons.settings_ethernet,
              ),
              const SizedBox(height: 16),
              _buildHelpStep(
                '4. Important Notes',
                '• Use your computer\'s local IP, not 127.0.0.1\n• Ensure firewall allows port 8000\n• Both devices on same Wi-Fi network',
                Icons.warning_amber,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF8E2DE2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Got It',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpStep(String title, String description, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _isValidIp(String ip) {
    final ipRegex = RegExp(
        r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
    return ip == 'localhost' || ipRegex.hasMatch(ip);
  }

  void _connectToServer() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isConnecting = true;
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    try {
      String ip = ipController.text.trim();
      SharedPreferences sh = await SharedPreferences.getInstance();

      ip = ip.replaceAll('http://', '').replaceAll('https://', '');

      sh.setString("url", "http://$ip:8000/myapp");
      sh.setString("img_url", "http://$ip:8000");

      if (mounted) {
        // Show success animation
        _showSuccessDialog();

        await Future.delayed(const Duration(milliseconds: 1500));

        if (mounted) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  MyLoginPage(title: ''),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(curve: curve),
                );
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Connection failed: Please check your IP address',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isConnecting = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 500),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green.shade600,
                        size: 60,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Connected Successfully!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Server: ${ipController.text}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Redirecting to login...',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String? validateIp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter server IP address';
    }

    if (!_isValidIp(value)) {
      return 'Please enter a valid IP address';
    }

    return null;
  }
}