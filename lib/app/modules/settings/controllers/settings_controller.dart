import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../Login/signIn.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../../toast.dart';
import '../../../data/local/my_shared_pref.dart';

class SettingsController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  RxString phone = "".obs;
  String? id = "";
  RxString userName = "".obs;

  @override
  void onInit() {
    inputData(); // Call the function to fetch data
    super.onInit();
  }

  signup() {
    FirebaseAuth.instance.signOut();
    showToast(message: "Successfully signed out");
    Get.off(SignInView());
  }

  void inputData() async {
    final User? user = auth.currentUser;
    id = user?.uid;
    if (id != null) {
      final userData =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
      // Assuming your user document has a field called 'userName' and 'phone'
      userName.value = userData['name'];
      phone.value = userData['phone'];
    }
  }

  // get is light theme from shared pref
  var isLightTheme = MySharedPref.getThemeIsLight();

  /// change the system theme
  changeTheme(bool value) {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }
}
