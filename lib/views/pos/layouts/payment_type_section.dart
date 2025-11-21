import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:readypos_flutter/config/app_color.dart';
import 'package:readypos_flutter/config/app_text.dart';
import 'package:readypos_flutter/controllers/misc/misc_provider.dart';
import 'package:readypos_flutter/controllers/payment_controller/payment_controller.dart';
import 'package:readypos_flutter/gen/assets.gen.dart';
import 'package:readypos_flutter/generated/l10n.dart';
import 'package:readypos_flutter/models/payment_model/payment_model.dart';
import 'package:readypos_flutter/utils/context_less_navigation.dart';
import 'package:readypos_flutter/views/pos/components/payment_card.dart';

import '../../../controllers/pos_controller.dart/pos_provider.dart';

class PaymentTypeSection extends ConsumerStatefulWidget {
  const PaymentTypeSection({super.key});

  @override
  _PaymentTypeSectionState createState() => _PaymentTypeSectionState();
}

class _PaymentTypeSectionState extends ConsumerState<PaymentTypeSection> {
  PaymentModel? paymentModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPaymentList();
    });
  }

  void getPaymentList() async {
    paymentModel =
        await ref.read(paymentControllerProvider.notifier).getPaymentList();
  }

  // String getPaymentMethod(BuildContext context, PaymentMethod method) {
  //   switch (method) {
  //     case PaymentMethod.cash:
  //       return S.of(context).cash;
  //     case PaymentMethod.draft:
  //       return "Draft";
  //     default:
  //       return '';
  //   }
  // }

  Future<dynamic> _paymentTypeBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(15.0.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      S.of(context).paymentMethod,
                      style: AppTextStyle.title,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: AdaptiveTheme.of(context).mode.isDark
                          ? Colors.white
                          : AppColor.darkBackgroundColor,
                    ),
                  )
                ],
              ),
              Gap(28.h),
              // Consumer(builder: (context, ref, _) {
              //   final selectedPaymentMethod =
              //       ref.watch(selectedPaymentMethodProvider);
              //   return GridView.builder(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 10.w,
              //       mainAxisSpacing: 20.h,
              //       mainAxisExtent: context.isTabletLandsCape ? 95.h : 55.0.h,
              //     ),
              //     itemCount: PaymentMethod.values.length,
              //     itemBuilder: (context, index) {
              //       return CustomPaymentButton(
              //         buttonText: getPaymentMethod(
              //             context, PaymentMethod.values[index]),
              //         isSelected:
              //             selectedPaymentMethod == PaymentMethod.values[index],
              //         onTap: () {
              //           ref.read(selectedPaymentMethodProvider.notifier).state =
              //               PaymentMethod.values[index];
              //           context.nav.pop();
              //         },
              //       );
              //     },
              //   );
              // }),
              Gap(8.h),

              // onilen payment
              Expanded(
                child: Consumer(builder: (context, ref, _) {
                  final paymentLoading = ref.watch(paymentControllerProvider);

                  return paymentLoading
                      ? const Center(child: CircularProgressIndicator())
                      : paymentModel == null
                          ? const Center(
                              child: Text("No Payemnt method found"),
                            )
                          : ListView.separated(
                              itemCount: paymentModel!
                                  .data!.paymentGatewayResources!.length,
                              itemBuilder: (context, index) {
                                final paymentMethod = paymentModel!
                                    .data!.paymentGatewayResources![index];
                                return PaymentCard(
                                  onTap: () {
                                    // ref.read(selectedPayment.notifier).state =
                                    //     paymentMethod.name!;
                                    ref
                                        .read(selectedCustomerpaymentProvider
                                            .notifier)
                                        .state = paymentMethod;
                                    context.nav.pop();
                                  },
                                  isActive: ref.watch(
                                          selectedCustomerpaymentProvider) ==
                                      paymentMethod,
                                  paymentGateways: paymentMethod,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Gap(8.h);
                              },
                            );
                }),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedPaymentMethod = ref.watch(selectedCustomerpaymentProvider);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      color: AdaptiveTheme.of(context).mode.isDark
          ? AppColor.darkBackgroundColor
          : Colors.white,
      child: InkWell(
        onTap: () async {
          await _paymentTypeBottomSheet(context);
        },
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColor.borderColor,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              context.isTabletLandsCape
                  ? SvgPicture.asset(
                      Assets.svgs.money,
                      height: 50.r,
                    )
                  : SvgPicture.asset(
                      Assets.svgs.money,
                      height: 24.h,
                      width: 24.w,
                    ),
              Gap(12.w),
              Expanded(
                child: Text(
                  // getPaymentMethod(context, selectedPaymentMethod),
                  ref.watch(selectedCustomerpaymentProvider)?.name ??
                      "Select Payment",
                  style: AppTextStyle.normalBody,
                ),
              ),
              Gap(12.w),
              SvgPicture.asset(Assets.svgs.arrowDown2),
            ],
          ),
        ),
      ),
    );
  }
}
