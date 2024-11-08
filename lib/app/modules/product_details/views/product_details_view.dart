import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 450.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDF1FA),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30.h,
                    left: 20.w,
                    right: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Get.offNamed(Routes.BASE),
                          icon: SvgPicture.asset(Constants.backArrowIcon),
                        ),
                        GetBuilder<ProductDetailsController>(
                          id: 'FavoriteButton',
                          builder: (_) => IconButton(
                            onPressed: controller.onFavoriteButtonPressed,
                            icon: SvgPicture.asset(
                              controller.product.isFavorite!
                                  ? Constants.favFilledIcon
                                  : Constants.favOutlinedIcon,
                              width: 16.w,
                              height: 15.h,
                              color: controller.product.isFavorite!
                                  ? null
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10.h,
                    bottom: 20.h,
                    child: Image.network(
                      controller.product.image!,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  controller.product.name!,
                  style: theme.textTheme.bodyText1,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      '\ ${controller.product.price} DT',
                      style: theme.textTheme.headline6,
                    ),
                    SizedBox(width: 30.w),
                    Icon(Icons.star_rounded, color: Color(0xFFFFC542)),
                    SizedBox(width: 5.w),
                    Text(
                      controller.product.rating!.toString(),
                      style: theme.textTheme.subtitle1?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '(${controller.product.reviews!})',
                      style: theme.textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(height: 10.h),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: CustomButton(
                  text: 'Add to Cart',
                  onPressed: () => controller.onAddToCartPressed(),
                  disabled: controller.product.quantity! > 0,
                  fontSize: 16.sp,
                  radius: 12.r,
                  verticalPadding: 12.h,
                  hasShadow: true,
                  shadowColor: theme.primaryColor,
                  shadowOpacity: 0.3,
                  shadowBlurRadius: 4,
                  shadowSpreadRadius: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
