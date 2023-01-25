import 'package:t_or_d/features/t_or_d/bottom_nav_view.dart';

import '../../routes/exports.dart';

class SplashScreenController extends GetxController {
  //final user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() async {
    super.onInit();

    await Future.delayed(
      const Duration(seconds: 3),
    );

    Get.to(() => const BottomNavigationView());
  }
}
