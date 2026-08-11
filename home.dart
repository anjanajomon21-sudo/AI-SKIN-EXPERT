//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'Fileupload.dart';
// import 'Symptombasedprediction.dart';
// import 'change password.dart';
// import 'chatbot.dart';
// import 'constant.dart';
// import 'loginnew.dart';
// import 'send feedback.dart';
// import 'view appointments.dart';
// import 'view doctors.dart';
// import 'view replay.dart';
// import 'view_prof_new (1).dart';
//
//
// void main(){
//   runApp(myapp());
// }
//
// class myapp extends StatelessWidget {
//   const myapp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//
//
//   String? profileImage;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadProfileImage();
//   }
//
//   Future<void> _loadProfileImage() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     setState(() {
//       profileImage = sh.getString('img');
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: const Color(0xfff5f7fa),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildHeader(context, size),
//             const SizedBox(height: 20),
//             _buildDashboard(context, size),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildHeader(BuildContext context, Size size) {
//     return Stack(
//       children: [
//         Container(
//           height: size.height * 0.35,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [primaryColor, secondaryColor],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(40),
//               bottomRight: Radius.circular(40),
//             ),
//           ),
//         ),
//
//         /// CHATBOT ICON (TOP LEFT)
//         Positioned(
//           top: size.height * 0.05,
//           left: 16,
//           child: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => ChatScreen()), // chatbot page
//               );
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.95),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 6,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: const [
//                   Icon(Icons.smart_toy_outlined,
//                       color: Colors.redAccent, size: 18),
//                   SizedBox(width: 6),
//                   Text(
//                     "Chat",
//                     style: TextStyle(
//                         color: Colors.redAccent,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//         /// LOGOUT BUTTON (TOP RIGHT)
//         Positioned(
//           top: size.height * 0.05,
//           right: 16,
//           child: GestureDetector(
//             onTap: () => Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => MyLoginPage(title: 'Login'),
//               ),
//             ),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.redAccent.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.redAccent.withOpacity(0.3),
//                     blurRadius: 6,
//                     offset: const Offset(0, 3),
//                   )
//                 ],
//               ),
//               child: Row(
//                 children: const [
//                   Icon(Icons.logout, color: Colors.white, size: 18),
//                   SizedBox(width: 6),
//                   Text(
//                     "Logout",
//                     style: TextStyle(color: Colors.white, fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//         /// PROFILE & TITLE
//         Positioned(
//           top: size.height * 0.08,
//           left: 0,
//           right: 0,
//           child: Column(
//             children: [
//               Hero(
//                 tag: "profilePic",
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundImage:
//                   profileImage != null && profileImage!.isNotEmpty
//                       ? NetworkImage(profileImage!)
//                       : const AssetImage("assets/images/aa.jpg")
//                   as ImageProvider,
//                   backgroundColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "Welcome Back!",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white70,
//                 ),
//               ),
//               const Text(
//                 "My Home",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//
//   Widget _buildDashboard(BuildContext context, Size size) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Wrap(
//         spacing: 16,
//         runSpacing: 16,
//         children: [
//           _dashboardCard(context, Icons.person, "Profile", Colors.blue,
//                   () => Navigator.push(context, MaterialPageRoute(builder: (_) => userProfile_new1(title: '')))),
//           _dashboardCard(context, Icons.medical_services, "Doctor", Colors.purple,
//                   () => Navigator.push(context, MaterialPageRoute(builder: (_) => ViewDoctors(title: '')))),
//           _dashboardCard(context, Icons.camera, "Skin Check", Colors.teal,
//                   () => Navigator.push(context, MaterialPageRoute(builder: (_) => FileUploadScreen()))),
//           _dashboardCard(context, Icons.lock_reset, "Change Pass", Colors.orange,
//                   () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChangePasswordPage()))),
//           _dashboardCard(context, Icons.analytics, "Symptoms", Colors.indigo,
//                   () => Navigator.push(context, MaterialPageRoute(builder: (_) => SymptombasedpredictionPage()))),
//           _dashboardCard(context, Icons.chat, "Reply", Colors.green,
//                   () => Navigator.push(context, MaterialPageRoute(builder: (_) => ViewReplyPage(title: 'View Reply')))),
//           _dashboardCard(context, Icons.feedback, "Feedback", Colors.pink,
//                   () => Navigator.push(context, MaterialPageRoute(builder: (_) => sendfeedbackPage(title: 'Feedback')))),
//           _dashboardCard(context, Icons.book_online, "Bookings", Colors.cyan,
//                   () => Navigator.push(context, MaterialPageRoute(builder: (_) => ViewAppointmentfull(title: 'Booking')))),
//         ],
//       ),
//     );
//   }
//
//   Widget _dashboardCard(BuildContext context, IconData icon, String title,
//       Color color, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//         height: 120,
//         width: 150,
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.85),
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//                 color: color.withOpacity(0.3),
//                 offset: const Offset(0, 6),
//                 blurRadius: 10)
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40, color: Colors.white),
//             const SizedBox(height: 10),
//             Text(
//               title,
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Fileupload.dart';
import 'Symptombasedprediction.dart';
import 'change password.dart';
import 'chatbot.dart';
import 'constant.dart';
import 'loginnew.dart';
import 'send feedback.dart';
import 'view appointments.dart';
import 'view doctors.dart';
import 'view replay.dart';
import 'view_prof_new (1).dart';

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
        primarySwatch: Colors.purple,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  String? profileImage;
  String userName = "User";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    _loadUserName();

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

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadProfileImage() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    setState(() {
      profileImage = sh.getString('img');
      userName = sh.getString('username') ?? "User";
    });
  }

  Future<void> _loadUserName() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    setState(() {
      userName = sh.getString('username') ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F7FA),
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            height: size.height * 0.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildHeader(size),
                  const SizedBox(height: 20),
                  _buildProjectDescription(),
                  const SizedBox(height: 25),
                  _buildDashboard(context, size),
                  const SizedBox(height: 30),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Drawer Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  Hero(
                    tag: "profilePic",
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: profileImage != null && profileImage!.isNotEmpty
                          ? NetworkImage(profileImage!)
                          : const AssetImage("assets/images/aa.jpg") as ImageProvider,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Patient',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            // Drawer Items
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  children: [
                    _buildDrawerItem(
                      icon: Icons.dashboard_outlined,
                      title: 'Dashboard',
                      onTap: () => Navigator.pop(context),
                    ),
                    _buildDrawerItem(
                      icon: Icons.person_outline,
                      title: 'My Profile',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => userProfile_new1(title: ''),
                          ),
                        );
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.medical_services_outlined,
                      title: 'Doctors',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ViewDoctors(title: ''),
                          ),
                        );
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.camera_alt_outlined,
                      title: 'Skin Analysis',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FileUploadScreen(),
                          ),
                        );
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.analytics_outlined,
                      title: 'Symptom Checker',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SymptombasedpredictionPage(),
                          ),
                        );
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.calendar_today_outlined,
                      title: 'Appointments',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ViewAppointmentfull(title: 'Booking'),
                          ),
                        );
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.chat_outlined,
                      title: 'Chat Support',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(),
                          ),
                        );
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.feedback_outlined,
                      title: 'Send Feedback',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => sendfeedbackPage(title: 'Feedback'),
                          ),
                        );
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.reply_outlined,
                      title: 'View Replies',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ViewReplyPage(title: 'View Reply'),
                          ),
                        );
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.lock_reset_outlined,
                      title: 'Change Password',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangePasswordPage(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    _buildDrawerItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      color: Colors.red,
                      onTap: () => _showLogoutDialog(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.grey.shade800,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey.shade400,
      ),
      onTap: onTap,
    );
  }

  Widget _buildHeader(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Button
          GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              child: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          // Logo
          const Row(
            children: [
              Icon(
                Icons.health_and_safety,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: 8),
              Text(
                'DermaAI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Profile Circle
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => userProfile_new1(title: ''),
                ),
              );
            },
            child: Hero(
              tag: "profilePic",
              child: CircleAvatar(
                radius: 22,
                backgroundImage: profileImage != null && profileImage!.isNotEmpty
                    ? NetworkImage(profileImage!)
                    : const AssetImage("assets/images/aa.jpg") as ImageProvider,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectDescription() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, Color(0xFFF0F4F8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, secondaryColor],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI-Powered Skin Analysis',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Advanced detection system',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'DermaAI uses cutting-edge deep learning algorithms to analyze skin conditions and provide accurate preliminary assessments. Upload images or describe symptoms for instant analysis.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeatureChip(Icons.photo_camera, 'Image Scan'),
                _buildFeatureChip(Icons.speed, 'Fast Results'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: primaryColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1,
            children: [
              // _buildDashboardCard(
              //   icon: Icons.person,
              //   title: "Profile",
              //   color: Colors.blue,
              //   gradient: const [Color(0xFF2193b0), Color(0xFF6dd5ed)],
              //   onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (_) => userProfile_new1(title: '')),
              //   ),
              // ),
              // _buildDashboardCard(
              //   icon: Icons.medical_services,
              //   title: "Doctors",
              //   color: Colors.purple,
              //   gradient: const [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
              //   onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (_) => ViewDoctors(title: '')),
              //   ),
              // ),
              _buildDashboardCard(
                icon: Icons.camera,
                title: "Skin Check",
                color: Colors.teal,
                gradient: const [Color(0xFF11998e), Color(0xFF38ef7d)],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FileUploadScreen()),
                ),
              ),
              _buildDashboardCard(
                icon: Icons.analytics,
                title: "Doctors",
                color: Colors.indigo,
                gradient: const [Color(0xFF5614B0), Color(0xFF9D50BB)],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ViewDoctors(title: '',)),
                ),
              ),
              // _buildDashboardCard(
              //   icon: Icons.calendar_today,
              //   title: "Bookings",
              //   color: Colors.cyan,
              //   gradient: const [Color(0xFF00B4DB), Color(0xFF0083B0)],
              //   onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (_) => ViewAppointmentfull(title: 'Booking')),
              //   ),
              // ),
              // _buildDashboardCard(
              //   icon: Icons.chat,
              //   title: "Chat",
              //   color: Colors.green,
              //   gradient: const [Color(0xFF56ab2f), Color(0xFFa8e063)],
              //   onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (_) => ChatScreen()),
              //   ),
              // ),
              // _buildDashboardCard(
              //   icon: Icons.feedback,
              //   title: "Feedback",
              //   color: Colors.pink,
              //   gradient: const [Color(0xFFeb3349), Color(0xFFf45c43)],
              //   onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (_) => sendfeedbackPage(title: 'Feedback')),
              //   ),
              // ),
              // _buildDashboardCard(
              //   icon: Icons.lock_reset,
              //   title: "Security",
              //   color: Colors.orange,
              //   gradient: const [Color(0xFFf12711), Color(0xFFf5af19)],
              //   onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (_) => ChangePasswordPage()),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required Color color,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Pattern
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(
                icon,
                size: 70,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.health_and_safety, color: primaryColor, size: 18),
              const SizedBox(width: 8),
              Text(
                'DermaAI - Skin Disease Detection System',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            '© 2024 All Rights Reserved',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyLoginPage(title: 'Login'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}