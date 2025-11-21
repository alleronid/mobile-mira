import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaymentMethodCard extends ConsumerWidget {
  const PaymentMethodCard({
    super.key,
    required this.imageLocation,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });
  final String imageLocation;
  final String title;

  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.h),
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.white,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imageLocation,
              height: 40.h,
              width: 40.w,
            ),
            Gap(15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Colors.purple,
                size: 15.h,
              ),
          ],
        ),
      ),
    );
  }
}
