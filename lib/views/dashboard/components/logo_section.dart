import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readypos_flutter/gen/assets.gen.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 1.w, right: 1.w, top: 1.h),
          child: SizedBox(
            height: 32.h,
            width: 120.w,
            child: Assets.pngs.logos.image(
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
