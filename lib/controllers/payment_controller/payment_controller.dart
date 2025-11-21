import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/payment_model/payment_model.dart';
import '../../services/payment_services.dart';

final paymentControllerProvider =
    StateNotifierProvider<PaymentController, bool>(
        (ref) => PaymentController(ref));

class PaymentController extends StateNotifier<bool> {
  final Ref ref;

  PaymentController(this.ref) : super(false);

  Future<PaymentModel?> getPaymentList() async {
    state = true;
    try {
      final response = await ref.read(paymentServiceProvider).getPaymentList();
      final paymentModel = PaymentModel.fromJson(response.data);

      final draft = PaymentGatewayResource(name: "Draft", logo: '');
      final cash = PaymentGatewayResource(name: "Cash", logo: '');
      final qris = PaymentGatewayResource(name: "qris", logo: '');

      paymentModel.data?.paymentGatewayResources?.insert(0, cash);
      paymentModel.data?.paymentGatewayResources?.insert(1, qris);
      paymentModel.data?.paymentGatewayResources?.add(draft);

      state = false;
      return paymentModel;
    } catch (error) {
      state = false;
      debugPrint(error.toString());
    }
    return null;
  }
}
