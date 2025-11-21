import 'dart:async';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:readypos_flutter/config/app_color.dart';
import 'package:readypos_flutter/config/app_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readypos_flutter/controllers/app_currency_provider.dart';
// import 'package:readypos_flutter/views/pos/components/payment_card.dart';
import 'package:readypos_flutter/utils/api_client.dart';
import 'package:readypos_flutter/config/app_constants.dart';
import 'package:readypos_flutter/utils/context_less_navigation.dart';
import 'package:readypos_flutter/generated/l10n.dart';
 

class QRISPaymentDetailsView extends ConsumerStatefulWidget {
  final String paymentContent;
  final String grandTotal;
  final int draftId;
  const QRISPaymentDetailsView({super.key, required this.paymentContent, this.grandTotal = '0', required this.draftId});

  @override
  ConsumerState<QRISPaymentDetailsView> createState() => _QRISPaymentDetailsViewState();
}

class _QRISPaymentDetailsViewState extends ConsumerState<QRISPaymentDetailsView> {
  late Timer _timer;
  int _remaining = 300;
  Timer? _statusTimer;
  bool _shownResult = false;
  bool _paymentSucceeded = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remaining > 0) {
        setState(() {
          _remaining -= 1;
        });
      } else {
        _timer.cancel();
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    });

    _statusTimer = Timer.periodic(const Duration(seconds: 2), (t) async {
      await _checkPaymentStatus();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _statusTimer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Future<void> _checkPaymentStatus() async {
    if (_shownResult) return;
    try {
      final String url = AppConstants.statusPurchase.replaceFirst('{purchaseId}', widget.draftId.toString());
      final Response resp = await ref.read(apiClientProvider).get(url);
      final dynamic status = resp.data?['data']?['sales']?['payment_status'];
      final String statusStr = status?.toString() ?? '1';
      switch (statusStr) {
        case '1':
          break;
        case '3':
          _shownResult = true;
          _statusTimer?.cancel();
          _timer.cancel();
          if (mounted) {
            setState(() {
              _paymentSucceeded = true;
            });
          }
          if (!mounted) return;
          await _showResultDialog(
            success: true,
            onOk: () {
              Navigator.of(context).pop();
            },
          );
          break;
        case '2':
          _shownResult = true;
          _statusTimer?.cancel();
          _timer.cancel();
          if (!mounted) return;
          await _showResultDialog(
            success: false,
            onOk: () {
              Navigator.of(context).pop();
              if (mounted) {
                context.nav.pop();
              }
            },
          );
          break;
        default:
          break;
      }
    } catch (_) {
      // ignore errors in polling
    }
  }

  Future<void> _showResultDialog({required bool success, required VoidCallback onOk}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                success ? Icons.verified : Icons.error,
                color: success ? Colors.green : Colors.red,
                size: 72.r,
              ),
              Gap(12.h),
              Text(
                success ? S.of(context).paymentSuccessShort : S.of(context).paymentFailed,
                style: AppTextStyle.title,
                textAlign: TextAlign.center,
              ),
              if (success) ...[
                Gap(8.h),
                Text(
                  S.of(context).transactionProcessed,
                  style: AppTextStyle.normalBody,
                  textAlign: TextAlign.center,
                ),
              ],
              Gap(16.h),
              SizedBox(
                width: 120.w,
                child: TextButton(
                  onPressed: onOk,
                  style: TextButton.styleFrom(
                    backgroundColor: success ? Colors.green : Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(S.of(context).ok),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final qrUrl =
        'https://api.qrserver.com/v1/create-qr-code/?data=${widget.paymentContent}';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).qrisDetailTitle,
          style: AppTextStyle.title,
        ),
        surfaceTintColor: const Color.fromARGB(255, 241, 233, 233),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 100.h, left: 16.r, right: 16.r, bottom: 16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(2.h),
              Consumer(builder: (context, ref, _) {
                final currency = ref.watch(appcurrencyNotifierProvider.notifier);
                final amount = double.tryParse(widget.grandTotal) ?? 0;
                final formatted = currency.currencyValue(amount);
                return Text(
                  '${S.of(context).totalPaymentLabel}: $formatted',
                  style: AppTextStyle.title,
                );
              }),
              if (!_paymentSucceeded) ...[
                Text(
                  S.of(context).validFor5Minutes,
                  style: AppTextStyle.normalBody.copyWith(
                    color: AppColor.darkBackgroundColor.withOpacity(0.7),
                  ),
                ),
                Gap(8.h),
                Text(
                  _formatTime(_remaining),
                  style: AppTextStyle.title,
                ),
                Gap(24.h),
                Container(
                  height: 240.r,
                  width: 240.r,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.borderColor, width: 1.w),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl: qrUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Gap(16.h),
                Text(
                  S.of(context).qrisScanInstruction,
                  style: AppTextStyle.normalBody,
                  textAlign: TextAlign.center,
                ),
              ] else ...[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.green, width: 1.w),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 72.r,
                      ),
                      Gap(12.h),
                      Text(
                        S.of(context).paymentSuccessPageTitle,
                        style: AppTextStyle.title,
                        textAlign: TextAlign.center,
                      ),
                      Gap(8.h),
                      Consumer(builder: (context, ref, _) {
                        final currency = ref.watch(appcurrencyNotifierProvider.notifier);
                        final amount = double.tryParse(widget.grandTotal) ?? 0;
                        final formatted = currency.currencyValue(amount);
                        return Text(
                          '${S.of(context).totalLabel}: $formatted',
                          style: AppTextStyle.normalBody,
                          textAlign: TextAlign.center,
                        );
                      }),
                      Gap(8.h),
                      Text(
                        S.of(context).thankYouPaymentReceived,
                        style: AppTextStyle.normalBody,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}