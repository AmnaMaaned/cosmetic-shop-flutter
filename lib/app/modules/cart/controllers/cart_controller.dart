import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import '../../../../toast.dart';
import '../../../../utils/dummy_helper.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';


class CartController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  // to hold the products in cart
  List<ProductModel> products = [];

  // to hold the total price of the cart products
  var total = 0.0;

  @override
  void onInit() {
    getCartProducts();
    super.onInit();
  }

  Future<void> add_panier() async {
    final User? user = auth.currentUser;
    String id = user!.uid;
    List<String?> names = products.map((product) => product.name).toList();
    String randomId = randomAlphaNumeric(20);
    double totale = (total * 100).roundToDouble() / 100;
    DocumentReference panier = await _firestore
        .collection("Panier")
        .doc(id)
        .collection('historique')
        .doc(randomId);
// Example list of names

    // Create a map with names and a single timestamp
    Map<String, dynamic> data = {};
    for (int i = 0; i < names.length; i++) {
      data['name$i'] = names[i];
    }
    // Add a single timestamp for the entire document
    data['timestamp'] = FieldValue.serverTimestamp();
    data['Total'] = totale;

    // Set the document with the name map
    try {
      await panier.set(data);
      showToast(message: "Panier added successfully!");
    } catch (error) {
      showToast(message: "Failed to add Panier: $error");
    }
  }

  /// when the user press on purchase now button
  onPurchaseNowPressed() {
    add_panier();
    Get.find<BaseController>().changeScreen(0);
    CustomSnackBar.showCustomSnackBar(
        title: 'Purchased', message: 'Order placed with success');
    // DummyHelper.prod.clear();
  }

  /// when the user press on increase button
  onIncreasePressed(int productId) {
    var product = DummyHelper.prod.firstWhere((p) => p.id == productId);
    product.quantity = product.quantity! + 1;
    getCartProducts();
    update(['ProductQuantity']);
  }

  /// when the user press on decrease button
  onDecreasePressed(int productId) {
    var product = DummyHelper.prod.firstWhere((p) => p.id == productId);
    if (product.quantity != 0) {
      product.quantity = product.quantity! - 1;
      getCartProducts();
      update(['ProductQuantity']);
    }
  }

  /// when the user press on delete icon
  onDeletePressed(int productId) {
    var product = DummyHelper.prod.firstWhere((p) => p.id == productId);
    product.quantity = 0;
    getCartProducts();
  }

  /// get the cart products from the product list
  getCartProducts() {
    products = DummyHelper.prod.where((p) => p.quantity! > 0).toList();
    // calculate the total price
    total = products.fold<double>(0, (p, c) => p + c.price! * c.quantity!);
    update();
  }
}
