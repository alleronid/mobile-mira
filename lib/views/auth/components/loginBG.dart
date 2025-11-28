import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:readypos_flutter/gen/assets.gen.dart';
import 'package:readypos_flutter/config/app_color.dart';
import 'package:readypos_flutter/config/app_text.dart';
import 'package:readypos_flutter/generated/l10n.dart';

class LoginBG extends StatelessWidget {
  const LoginBG({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(70.h),
              Gap(70.h),
              Center(
                child: SizedBox(
                  height: 110.h,
                  width: 380.w,
                  child: Assets.pngs.logos.image(
                    height: 110.h,
                    width: 380.w,
                    fit: BoxFit.contain,
                  ),
                ),
              )
                  .animate(
                    delay: 400.ms,
                  )
                  .slideY(
                    begin: 6.5,
                    end: 0.0,
                    duration: const Duration(milliseconds: 1000),
                  ),
              Gap(17.h),
              Text(
                S.of(context).mirraTagline,
                style: AppTextStyle.largeBody.copyWith(
                  color: AppColor.primaryColor,
                  letterSpacing: 1.2,
                ),
              ),
              Gap(28.h),
              // SizedBox(
              //   height: 150.h,
              //   width: 210.w,
              //   child: SvgPicture.asset(
              //     Assets.svgs.loginBG,
              //   ),
              // ).animate().slideY(
              //       begin: 6,
              //       end: 0.0,
              //       duration: const Duration(milliseconds: 1000),
              //     )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: child
              .animate(
                  // delay: 800.ms,
                  // autoPlay: false,
                  )
              .fadeIn(
                begin: 0.4,
                duration: const Duration(milliseconds: 1200),
              )
              .animate()
              .slideY(
                begin: 1.5,
                end: 0.0,
                duration: const Duration(milliseconds: 1200),
              ),
        )
      ],
    );
  }
}
