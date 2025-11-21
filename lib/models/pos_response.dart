class POSResponse {
  final String? invoicePDFUrl;
  final String? qrUrl;
  final int? draftId;
  final String? redirectUrl;
  final int? orderId;
  final String? paymentContent;
  final num? grandTotal;

  POSResponse({
    this.invoicePDFUrl,
    this.qrUrl,
    this.draftId,
    this.redirectUrl,
    this.orderId,
    this.paymentContent,
    this.grandTotal,
  });
}
