import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shivalik_school/Exam/stu_result.dart';
import 'package:shivalik_school/api_service.dart';
import 'package:shivalik_school/connect_teacher/connect_with_us.dart';
import 'package:shivalik_school/dashboard/calendar.dart';
import 'package:shivalik_school/homework/homework_page.dart';
import 'package:shivalik_school/payment/fee_details_page.dart';
import 'package:shivalik_school/payment/payment_page.dart';
import 'package:shivalik_school/subjects_page.dart';

class DashboardNew extends StatefulWidget {
  const DashboardNew({super.key});

  @override
  State<DashboardNew> createState() => _DashboardNewState();
}

class _DashboardNewState extends State<DashboardNew> {
  int _currentIndex = 0;
  bool isLoading = true;

  int dues = 0;
  int payments = 0;
  int subjects = 0;
  String lastPaymentDate = '';
  String todayStatus = '';

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  // 🔹 Pages for Bottom Navigation
  // final List<Widget> _pages = const [
  //   DashboardHomeBody(),
  //   Center(child: Text("Academics")),
  //   Center(child: Text("Attendance")),
  //   Center(child: Text("Contact")),
  //   Center(child: Text("Profile")),
  // ];
  Future<void> fetchDashboardData() async {
    final response = await ApiService.post(context, "/student/dashboard");

    if (response == null) return;

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        dues = data['dues'] ?? 0;
        payments = int.tryParse(data['payments'].toString()) ?? 0;
        subjects = data['subjects'] ?? 0;
        todayStatus = data['today_status'] ?? '';

        final rawDate = data['payment_date'] ?? '';
        if (rawDate.isNotEmpty) {
          try {
            final d = DateTime.parse(rawDate);
            lastPaymentDate = '${d.day}-${d.month}-${d.year}';
          } catch (_) {
            lastPaymentDate = rawDate;
          }
        }

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        titleSpacing: 0,

        // ✅ BACK BUTTON
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),

        // ✅ TITLE
        title: const Text(
          "Shiwalik Public School",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        // ✅ RIGHT ICONS
        actions: const [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 12),
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 12),
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage("assets/images/logo.png"),
          ),
          SizedBox(width: 12),
        ],
      ),

      // ================= BODY =================
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : IndexedStack(
              index: _currentIndex,
              children: [
                DashboardHomeBody(
                  dues: dues,
                  payments: payments,
                  subjects: subjects,
                  lastPaymentDate: lastPaymentDate,
                  todayStatus: todayStatus,
                ),
                const Center(child: Text("Academics")),
                const Center(child: Text("Attendance")),
                const Center(child: Text("Contact")),
                const Center(child: Text("Profile")),
              ],
            ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Academics"),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: "Attendance",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Contact"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

/// 🔹 DASHBOARD HOME BODY (SCROLLABLE)

class DashboardHomeBody extends StatefulWidget {
  final int dues;
  final int payments;
  final int subjects;
  final String lastPaymentDate;
  final String todayStatus;

  const DashboardHomeBody({
    super.key,
    required this.dues,
    required this.payments,
    required this.subjects,
    required this.lastPaymentDate,
    required this.todayStatus,
  });

  @override
  State<DashboardHomeBody> createState() => _DashboardHomeBodyState();
}

class _DashboardHomeBodyState extends State<DashboardHomeBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: DashboardCard(
                  title: 'Fee Amount',
                  value: widget.dues.toString(),

                  borderColor: AppColors.danger,
                  backgroundColor: AppColors.danger.shade50,
                  textColor: AppColors.danger,
                ),

                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FeeDetailsPage()),
                ),
              ),
              GestureDetector(
                child: DashboardCard(
                  title: 'Last Pay',
                  value: widget.payments.toString(),

                  borderColor: AppColors.success,
                  backgroundColor: AppColors.success.shade50,
                  textColor: AppColors.success,
                  date: widget.lastPaymentDate,
                ),

                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PaymentPage()),
                ),
              ),
              GestureDetector(
                child: DashboardCard(
                  title: 'Subjects',
                  value: widget.subjects.toString(),

                  borderColor: AppColors.info,
                  backgroundColor: AppColors.info.shade50,
                  textColor: AppColors.info,
                ),

                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SubjectsPage()),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // -------- Today Attendance ----------
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.school, color: AppColors.primary),
                const SizedBox(width: 10),
                const Text("School", style: TextStyle(fontSize: 16)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.todayStatus.isEmpty
                        ? "Not Marked"
                        : widget.todayStatus,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Quick Links",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 0.78,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 18,
            crossAxisSpacing: 20,
            children: [
              DashboardItem(
                Icons.menu_book,
                "Assignment",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HomeworkPage()),
                  );
                },
              ),

              DashboardItem(
                Icons.library_books,
                "Library",
                // onTap: () {
                //   Navigator.push(context,
                //     MaterialPageRoute(builder: (_) => LibraryPage()),
                //   );
                // },
              ),

              DashboardItem(
                Icons.bar_chart,
                "Report Card",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => StudentResultPage()),
                  );
                },
              ),

              DashboardItem(
                Icons.calendar_month,
                "Calendar",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => StudentCalendarPage()),
                  );
                },
              ),

              DashboardItem(
                Icons.receipt_long,
                "Fee Details",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FeeDetailsPage()),
                  );
                },
              ),

              DashboardItem(
                Icons.celebration,
                "Happenings",
                onTap: () {
                  // Events page
                },
              ),

              DashboardItem(
                Icons.campaign,
                "Notices",
                onTap: () {
                  // Notices page
                },
              ),

              DashboardItem(
                Icons.photo,
                "Gallery",
                onTap: () {
                  // Gallery page
                },
              ),

              DashboardItem(
                Icons.support_agent,
                "Support",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConnectWithUsPage(
                        teacherId: 0,
                        teacherName: '',
                        teacherPhoto: '',
                      ),
                    ),
                  );
                },
              ),

              DashboardItem(
                Icons.health_and_safety,
                "Health",
                onTap: () {
                  // Health records page
                },
              ),

              DashboardItem(
                Icons.account_balance_wallet,
                "Ledger",
                onTap: () {
                  // Ledger page
                },
              ),
            ],
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

/// 🔹 SINGLE DASHBOARD ITEM

class DashboardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const DashboardItem(this.icon, this.title, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Icon(icon, color: AppColors.primary, size: 25),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final String? date;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.borderColor,
    required this.backgroundColor,
    required this.textColor,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 98,
      height: 88,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          if (date != null && date!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 2.0),
              child: Text(
                date!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: textColor.withOpacity(0.8),
                ),
              ),
            )
          else
            const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
