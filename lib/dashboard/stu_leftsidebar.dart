
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shivalik_school/api_service.dart';
// import 'package:shivalik_school/connect_teacher/connect_with_us.dart';
// import 'package:shivalik_school/dashboard/calendar.dart';
// import 'package:shivalik_school/dashboard/dashboard_screen.dart';
// import 'package:shivalik_school/homework/homework_page.dart';
// import 'package:shivalik_school/dashboard/timetable_page.dart';
// import 'package:shivalik_school/Exam/exam_schedule.dart';
// import 'package:shivalik_school/Exam/stu_result.dart';

// import 'package:shivalik_school/login_page.dart';
// import 'package:shivalik_school/payment/fee_details_page.dart';
// import 'package:shivalik_school/payment/payment_page.dart';
// import 'package:shivalik_school/profile_page.dart';
// import 'package:shivalik_school/school_info_page.dart';
// import 'package:shivalik_school/complaint/view_complaints_page.dart';
// import 'package:shivalik_school/subjects_page.dart';
// import 'package:shivalik_school/syllabus/syllabus.dart';
// import 'package:shivalik_school/Attendance_UI/stu_attendance_report.dart';

// class LeftSidebarMenu extends StatelessWidget {
//   final String studentName;
//   final String studentPhoto;
//   final String studentClass;
//   final String studentsection;

//   const LeftSidebarMenu({
//     super.key,
//     required this.studentName,
//     required this.studentPhoto,
//     required this.studentClass,
//     required this.studentsection,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 270,
//       child: Drawer(
//         child: ListView(
//           children: [
//             Container(
//               color: AppColors.primary,
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//               height: 120,
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 26,
//                     backgroundColor: Colors.grey.shade300,
//                     child: ClipOval(
//                       child: Image.network(
//                         studentPhoto,
//                         width: 52,
//                         height: 52,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Image.asset(
//                             AppAssets.defaultAvatar,
//                             width: 52,
//                             height: 52,
//                             fit: BoxFit.cover,
//                           );
//                         },
//                       ),
//                     ),
//                   ),

//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           studentName,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         ),
//                         Text(
//                           'Class: $studentClass',
//                           style: const TextStyle(
//                             color: Colors.white70,
//                             fontSize: 14,
//                           ),
//                         ),
//                         Text(
//                           'Section: ${studentsection.isNotEmpty ? studentsection : "-"}',
//                           style: const TextStyle(
//                             color: Colors.white70,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // sidebarTile(
//             //   context: context,
//             //   icon: Icons.dashboard,
//             //   title: 'Dashboard',
//             //   onTap: () {
//             //     Navigator.push(
//             //       context,
//             //       MaterialPageRoute(builder: (_) => DashboardScreen()),
//             //     );
//             //   },
//             // ),
//             sidebarTile(
//               icon: Icons.dashboard,
//               context: context,
//               title: 'Dashboard',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => DashboardScreen()),
//                 );
//               },
//             ),

//             sidebarTile(
//               icon: Icons.person,
//               context: context,
//               title: 'Profile',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => ProfilePage()),
//                 );
//               },
//             ),

//             sidebarTile(
//               icon: Icons.book,
//               context: context,
//               title: 'Homeworks',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => HomeworkPage()),
//                 );
//               },
//             ),
//             sidebarTile(
//               context: context,
//               icon: Icons.calendar_month,
//               title: 'Attendance',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => StudentAttendanceScreen()),
//                 );
//               },
//             ),
//             sidebarTile(
//               context: context,
//               icon: Icons.calendar_today,
//               title: 'Time-Table',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const TimeTablePage()),
//                 );
//               },
//             ),
//             sidebarTile(
//               context: context,
//               icon: Icons.calendar_month,
//               title: 'Calendar',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => StudentCalendarPage()),
//                 );
//               },
//             ),

//             sidebarTile(
//               context: context,
//               icon: Icons.subject,
//               title: 'Subjects',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => SubjectsPage()),
//                 );
//               },
//             ),
//             sidebarTile(
//               context: context,
//               icon: Icons.book_sharp,
//               title: 'Syllabus',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => SyllabusPage()),
//                 );
//               },
//             ),
//             sidebarTile(
//               context: context,
//               icon: Icons.receipt_long_outlined,
//               title: 'Exam Schedule',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => ExamSchedulePage()),
//                 );
//               },
//             ),
//             sidebarTile(
//               context: context,
//               icon: Icons.report,
//               title: 'Complaint',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const ViewComplaintPage()),
//                 );
//               },
//             ),
//             sidebarTile(
//               context: context,
//               icon: Icons.attach_money,
//               title: 'Fees',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const FeeDetailsPage()),
//                 );
//               },
//             ),
//             sidebarTile(
//               context: context,
//               icon: Icons.payment,
//               title: 'Payment',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => PaymentPage()),
//                 );
//               },
//             ),
//             sidebarTile(
//               context: context,
//               icon: Icons.list_alt_outlined,
//               title: 'Result',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => StudentResultPage()),
//                 );
//               },
//             ),
//             sidebarTile(
//               context: context,
//               icon: Icons.school,
//               title: 'School Info',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => SchoolInfoPage()),
//                 );
//               },
//             ),

//             sidebarTile(
//               context: context,
//               icon: Icons.support_agent,
//               title: 'Contact & Support',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ConnectWithUsPage(
//                       teacherId: 0,
//                       teacherName: '',
//                       teacherPhoto: '',
//                     ),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout, color: AppColors.danger),
//               title: const Text(
//                 'Logout',
//                 style: TextStyle(color: AppColors.danger),
//               ),
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   builder: (_) => AlertDialog(
//                     title: const Text("Logout"),
//                     content: const Text("Are you sure you want to logout?"),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text(
//                           "Cancel",
//                           style: TextStyle(color: AppColors.primary),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () async {
//                           Navigator.pop(context);

//                           final prefs = await SharedPreferences.getInstance();
//                           await prefs.clear();
//                           if (!context.mounted) return;
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(builder: (_) => LoginPage()),
//                             (route) => false,
//                           );
//                         },
//                         child: const Text("Logout"),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget sidebarTile({
//   required BuildContext context,
//   required IconData icon,
//   required String title,
//   required VoidCallback onTap,
// }) {
//   return ListTile(
//     contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 0),
//     visualDensity: VisualDensity(vertical: -2),

//     leading: Icon(icon),
//     title: Text(title),

//     onTap: () {
//       Navigator.pop(context);
//       Future.microtask(onTap);
//     },
//   );
// }
