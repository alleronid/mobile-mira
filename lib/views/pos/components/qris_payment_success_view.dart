import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:readypos_flutter/config/app_color.dart';
import 'package:readypos_flutter/config/app_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readypos_flutter/controllers/app_currency_provider.dart';
import 'package:readypos_flutter/views/pos/components/payment_card.dart';
 

class QRISPaymentDetailsView extends StatefulWidget {
  final String paymentContent;
  final String grandTotal;
  const QRISPaymentDetailsView({super.key, required this.paymentContent, this.grandTotal = '0'});

  @override
  State<QRISPaymentDetailsView> createState() => _QRISPaymentDetailsViewState();
}

class _QRISPaymentDetailsViewState extends State<QRISPaymentDetailsView> {
  late Timer _timer;
  int _remaining = 300;

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
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final qrUrl =
        'https://api.qrserver.com/v1/create-qr-code/?data=${widget.paymentContent}';
   
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Transaksi',
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
                  'Total Pembayaran: $formatted',
                  style: AppTextStyle.title,
                );
              }),
              Text(
                'Berlaku 5 Menit',
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
                'Scan atau download QRIS untuk melanjutkan pembayaran anda melalui E-Wallet atau Mobile Banking',
                style: AppTextStyle.normalBody,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}