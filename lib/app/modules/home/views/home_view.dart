import 'package:ecommerce_app/app/components/screen_title.dart';
import 'package:ecommerce_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../utils/dummy_helper.dart';
import '../../../components/product_item.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? CircularProgressIndicator() // Show loading indicator while data is being fetched
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: RefreshIndicator(
                  onRefresh: () => controller
                      .getProductsFromFirestore(), // Manually trigger data fetch
                  child: ListView(
                    children: [
                      30.verticalSpace,
                      const ScreenTitle(
                        title: 'Home',
                      ),
                      20.verticalSpace,
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.w,
                          mainAxisSpacing: 15.h,
                          mainAxisExtent: 260.h,
                        ),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: DummyHelper.prod.length,
                        itemBuilder: (context, index) => ProductItem(
                          product: DummyHelper.prod[index],
                        ),
                      ),
                      10.verticalSpace,
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
