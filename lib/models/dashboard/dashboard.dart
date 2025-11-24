import 'dart:convert';

import 'package:flutter/foundation.dart';

class DashboardInfo {
  final double sale;
  final double purchase;
  final double profit;
  final double purchaseDue;
  final int maxChartAmount;
  final List<PurchaseAndSaleChart> purchaseAndSaleChart;
  final List<String> dates;
  DashboardInfo({
    required this.sale,
    required this.purchase,
    required this.profit,
    required this.purchaseDue,
    required this.maxChartAmount,
    required this.purchaseAndSaleChart,
    required this.dates,
  });

  DashboardInfo copyWith({
    double? sale,
    double? purchase,
    double? profit,
    double? purchaseDue,
    int? maxChartAmount,
    List<PurchaseAndSaleChart>? purchaseAndSaleChart,
    List<String>? dates,
  }) {
    return DashboardInfo(
      sale: sale ?? this.sale,
      purchase: purchase ?? this.purchase,
      profit: profit ?? this.profit,
      purchaseDue: purchaseDue ?? this.purchaseDue,
      maxChartAmount: maxChartAmount ?? this.maxChartAmount,
      purchaseAndSaleChart: purchaseAndSaleChart ?? this.purchaseAndSaleChart,
      dates: dates ?? this.dates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sale': sale,
      'purchase': purchase,
      'profit': profit,
      'purchase_due': purchaseDue,
      'max_chart_amount': maxChartAmount,
      'purchase_and_sale_chart':
          purchaseAndSaleChart.map((x) => x.toMap()).toList(),
      'dates': dates,
    };
  }

  factory DashboardInfo.fromMap(Map<String, dynamic> map) {
    return DashboardInfo(
      sale: map['sale'] as double,
      purchase: map['purchase'] as double,
      profit: map['profit'] as double,
      purchaseDue: map['purchase_due'] as double,
      maxChartAmount: map['max_chart_amount'].toInt() as int,
      purchaseAndSaleChart: List<PurchaseAndSaleChart>.from(
        (map['purchase_and_sale_chart'] as List<dynamic>)
            .map<PurchaseAndSaleChart>(
          (x) => PurchaseAndSaleChart.fromMap(x as Map<String, dynamic>),
        ),
      ),
      dates: List<String>.from(
        (map['dates'] as List<dynamic>? ?? const [])
            .map((x) => x.toString()),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardInfo.fromJson(String source) =>
      DashboardInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DashboardInfo(sale: $sale, purchase: $purchase, profit: $profit, purchase_due: $purchaseDue, max_chart_amount: $maxChartAmount, purchase_and_sale_chart: $purchaseAndSaleChart, dates: $dates)';
  }

  @override
  bool operator ==(covariant DashboardInfo other) {
    if (identical(this, other)) return true;

    return other.sale == sale &&
        other.purchase == purchase &&
        other.profit == profit &&
        other.purchaseDue == purchaseDue &&
        other.maxChartAmount == maxChartAmount &&
        listEquals(other.purchaseAndSaleChart, purchaseAndSaleChart) &&
        listEquals(other.dates, dates);
  }

  @override
  int get hashCode {
    return sale.hashCode ^
        purchase.hashCode ^
        profit.hashCode ^
        purchaseDue.hashCode ^
        maxChartAmount.hashCode ^
        purchaseAndSaleChart.hashCode ^
        dates.hashCode;
  }
}

class PurchaseAndSaleChart {
  final double purchase;
  final double sale;
  PurchaseAndSaleChart({
    required this.purchase,
    required this.sale,
  });

  PurchaseAndSaleChart copyWith({
    double? purchase,
    double? sale,
  }) {
    return PurchaseAndSaleChart(
      purchase: purchase ?? this.purchase,
      sale: sale ?? this.sale,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'purchase': purchase,
      'sale': sale,
    };
  }

  factory PurchaseAndSaleChart.fromMap(Map<String, dynamic> map) {
    return PurchaseAndSaleChart(
      purchase: map['purchase'] as double,
      sale: map['sale'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchaseAndSaleChart.fromJson(String source) =>
      PurchaseAndSaleChart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PurchaseAndSaleChart(purchase: $purchase, sale: $sale)';

  @override
  bool operator ==(covariant PurchaseAndSaleChart other) {
    if (identical(this, other)) return true;

    return other.purchase == purchase && other.sale == sale;
  }

  @override
  int get hashCode => purchase.hashCode ^ sale.hashCode;
}
