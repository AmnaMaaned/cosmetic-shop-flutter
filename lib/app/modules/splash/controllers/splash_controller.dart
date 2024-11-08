import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../Login/signIn.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    // Simulate a splash screen delay
    await Future.delayed(const Duration(seconds: 4));
    // Check if user is authenticated
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // If user is authenticated, navigate to HomePage
        Get.offNamed(AppPages.BASE);
      } else {
        // If user is not authenticated, navigate to SignInView
        Get.off(const SignInView());
      }
    });
  }
}
