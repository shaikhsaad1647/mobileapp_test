import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp_test/controllers/login_controller.dart';
import '../../helper/text_styles.dart';

class DashboardScreen extends StatelessWidget {
  final String userName;
  const DashboardScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<LoginController>();
    final userData = controller.dummyUsers[controller.employeeId.value];

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _buildProfileCard(size, controller, userData),
            _buildContentSection(size),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(Size size, LoginController controller, Map<String, String>? userData) {
    return Container(
      height: size.height * 0.33,
      width: size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/profilebg.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02,
          ),
          child: Card(
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/profile.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.employeeId.value,
                              style: AppTextStyles.regular(16, Colors.white),
                            ),
                            Text(
                              userName,
                              style: AppTextStyles.bold(20, Colors.white),
                            ),
                            Text(
                              userData?['email'] ?? '',
                              style: AppTextStyles.regular(14, Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Company:   ',
                        style: AppTextStyles.regular(14, Colors.grey),
                      ),
                      Text(
                        userData?['company'] ?? 'N/A',
                        style: AppTextStyles.regular(14, Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Platform:   ',
                        style: AppTextStyles.regular(14, Colors.grey),
                      ),
                      Text(
                        userData?['platform'] ?? 'N/A',
                        style: AppTextStyles.regular(14, Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection(Size size) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.28),
      child: Container(
        height: size.height - (size.height * 0.28),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          image: DecorationImage(
            image: AssetImage('assets/images/dashboardbg.png'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop),
          ),
          color: Color(0xFFFBFBFB),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.05,
            bottom: size.height * 0.02,
            left: size.width * 0.05,
            right: size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key functions',
                style: AppTextStyles.bold(18, Colors.black),
              ),
              const SizedBox(height: 10),
              _buildKeyFunctionsGrid(),
              const SizedBox(height: 10),
              Text(
                'Announcement',
                style: AppTextStyles.bold(18, Colors.black),
              ),
              _buildAnnouncementCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeyFunctionsGrid() {
    const keyFunctions = [
      {"title": "Request", "image": "assets/images/request.png"},
      {"title": "Complaint", "image": "assets/images/complaint.png"},
      {"title": "Salary\nSlip", "image": "assets/images/salaryslip.png"},
      {"title": "Chat", "image": "assets/images/chat.png"},
      {"title": "Loan\nBalance", "image": "assets/images/loanbalance.png"},
      {"title": "Asset\nAcceptance", "image": "assets/images/assetacceptance.png"},
      {"title": "Update\nInformation", "image": "assets/images/updateinformation.png"},
      {"title": "Emergency\nContact", "image": "assets/images/emergencycontact.png"},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: keyFunctions.length,
      itemBuilder: (context, index) {
        final function = keyFunctions[index];
        return Column(
          children: [
            Image.asset(
              function['image']!,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              function['title']!,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular(12, Colors.black),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnnouncementCard() {
    const announcement = {
      "title": "Title here",
      "description": "Description of the announcement in details will come here",
      "postedDate": "12/08/2025",
    };

    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(
              'assets/images/announcement.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcement['title']!,
                    style: AppTextStyles.bold(16, Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    announcement['description']!,
                    style: AppTextStyles.regular(14, Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Posted on: ${announcement['postedDate']}',
                    style: AppTextStyles.regular(12, Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}