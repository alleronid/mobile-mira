// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readypos_flutter/config/app_color.dart';
import 'package:readypos_flutter/gen/assets.gen.dart';

import '../../../models/payment_model/payment_model.dart';

class PaymentCard extends StatelessWidget {
  final PaymentGatewayResource paymentGateways;
  final bool isActive;
  final void Function()? onTap;
  const PaymentCard({
    super.key,
    required this.paymentGateways,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            border: Border.all(
                color: isActive
                    ? const Color(0xFF8322FF)
                    : const Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/radio.svg',
                      width: 22.sp,
                      colorFilter: ColorFilter.mode(
                        isActive
                            ? const Color(0xFF8322FF)
                            : const Color(0xFFD9D9D9),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Text(paymentGateways.name ?? '',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ))
                  ],
                ),
              ),
              paymentGateways.name == 'Cash'
                  ? Image.asset(
                      Assets.pngs.cash.path,
                      width: 40.w,
                      height: 40.h,
                      color: AppColor.primaryColor,
                    )
                  : paymentGateways.name == 'Draft'
                      ? Image.asset(
                          Assets.pngs.draft.path,
                          width: 40.w,
                          height: 40.h,
                          color: AppColor.primaryColor,
                        )
                      : (paymentGateways.name?.toLowerCase().contains('qr') ?? false)
                          ? SvgPicture.asset(
                              'assets/svgs/qr.svg',
                              width: 40.w,
                              height: 40.h,
                            )
                      : CachedNetworkImage(
                          imageUrl: paymentGateways.logo ?? '',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              SvgPicture.asset(
                            Assets.svgs.money,
                            width: 40.w,
                            height: 40.h,
                          ),
                          width: 80.w,
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
