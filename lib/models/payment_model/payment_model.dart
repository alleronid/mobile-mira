// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
    final String? message;
    final Data? data;

    PaymentModel({
        this.message,
        this.data,
    });

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    final List<PaymentGatewayResource>? paymentGatewayResources;

    Data({
        this.paymentGatewayResources,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        paymentGatewayResources: json["paymentGatewayResources"] == null ? [] : List<PaymentGatewayResource>.from(json["paymentGatewayResources"]!.map((x) => PaymentGatewayResource.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "paymentGatewayResources": paymentGatewayResources == null ? [] : List<dynamic>.from(paymentGatewayResources!.map((x) => x.toJson())),
    };
}

class PaymentGatewayResource {
    final String? name;
    final String? logo;

    PaymentGatewayResource({
        this.name,
        this.logo,
    });

    factory PaymentGatewayResource.fromJson(Map<String, dynamic> json) => PaymentGatewayResource(
        name: json["name"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
    };
}
