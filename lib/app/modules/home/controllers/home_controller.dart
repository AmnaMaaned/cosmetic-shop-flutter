import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../utils/dummy_helper.dart';
import '../../../data/models/product_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs; // Observable boolean to track loading state

  @override
  void onInit() {
    getProductsFromFirestore();
    super.onInit();
  }

  Future<void> getProductsFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('products').get();

      // Clear the existing products in the list
      DummyHelper.prod.clear();

      // Map the Firebase documents to ProductModel objects and add them to the 'prod' list
      querySnapshot.docs.forEach((doc) {
        DummyHelper.prod.add(ProductModel.fromFirestore(doc));
      });
    } catch (e) {
      print('Error retrieving products: $e');
    } finally {
      // Set loading to false once data fetching is complete
      isLoading.value = false;
    }
  }
}
