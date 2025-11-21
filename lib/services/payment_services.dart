import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/app_constants.dart';
import '../../utils/api_client.dart';

final paymentServiceProvider = Provider((ref) => PaymentService(ref));


abstract class PaymentRepository {
  Future<Response> getPaymentList();
}

class PaymentService implements PaymentRepository {
  final Ref ref;
  PaymentService(this.ref);
  @override
  Future<Response> getPaymentList() async {
    final response =
        await ref.read(apiClientProvider).get(AppConstants.paymentList);
    return response;
  }
}

