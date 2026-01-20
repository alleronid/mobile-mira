import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:readypos_flutter/utils/api_client.dart';
import 'package:readypos_flutter/config/app_constants.dart';

final authServiceProvider = Provider((ref) => AuthService(ref));

abstract class AuthRepository {
  Future<Response> login({
    required String email,
    required String password,
  });
  Future<Response> profileUpdate({
    required Map<String, dynamic> data,
  });
  Future<Response> passwordChange({
    required Map<String, dynamic> data,
  });
  Future<Response> forgotPassword({
    required String email,
  });
  Future<Response> getAppCurrency();
}

class AuthService implements AuthRepository {
  final Ref ref;
  AuthService(this.ref);

  @override
  Future<Response> login(
      {required String email, required String password}) async {
    final response =
        await ref.read(apiClientProvider).post(AppConstants.loginUrl, data: {
      "email": email,
      "password": password,
    });

    return response;
  }

  @override
  Future<Response> profileUpdate({required Map<String, dynamic> data}) async {
    final map = Map<String, dynamic>.from(data);
    if (map['image'] != null && map['image'] is String && (map['image'] as String).isNotEmpty) {
      final path = map['image'] as String;
      map['image'] = await MultipartFile.fromFile(
        path,
        filename: path.split(RegExp(r'[\\/]')).isNotEmpty
            ? path.split(RegExp(r'[\\/]')).last
            : 'profile_image.jpg',
      );
    } else {
      map.remove('image');
    }
    final formData = FormData.fromMap(map);
    final response = ref
        .read(apiClientProvider)
        .post(AppConstants.profileUpdate, data: formData);
    return response;
  }

  @override
  Future<Response> passwordChange({required Map<String, dynamic> data}) {
    final map = Map<String, dynamic>.from(data);
    try {
      final authBox = Hive.box(AppConstants.authBox);
      final user = authBox.get(AppConstants.userData);
      final id = user != null ? user['id'] : null;
      if (id != null) {
        map['id'] = id;
      }
    } catch (_) {}
    final response = ref
        .read(apiClientProvider)
        .put(AppConstants.passwordChange, data: map);
    return response;
  }

  @override
  Future<Response> forgotPassword({required String email}) async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.forgotPassword, data: {
      'email': email,
    });
    return response;
  }

  @override
  Future<Response> getAppCurrency() {
    final response = ref.read(apiClientProvider).get(AppConstants.appcurrency);
    return response;
  }
}
