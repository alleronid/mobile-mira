// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readypos_flutter/controllers/pos_controller.dart/pos_provider.dart';
import 'package:readypos_flutter/routes.dart';

import '../../../utils/context_less_navigation.dart';
import 'custom_dialog.dart';

class WebPayementScreen extends ConsumerStatefulWidget {
  final WebPaymentScreenArg webPaymentScreenAr;
  const WebPayementScreen({
    super.key,
    required this.webPaymentScreenAr,
    // required String redirectUrl,
  });

  @override
  ConsumerState<WebPayementScreen> createState() => _WebPayementScreenState();
}

class _WebPayementScreenState extends ConsumerState<WebPayementScreen> {
  late InAppWebViewController _webViewController;
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        if (!didPop) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.core,
            (route) => false,
          );
        }
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest:
                  URLRequest(url: WebUri(widget.webPaymentScreenAr.paymentUrl)),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onCreateWindow: (controller, createWindowRequest) async {
                final targetUrl = createWindowRequest.request.url?.toString() ?? '';
                await _handleUrl(targetUrl, ref);
                await controller.loadUrl(urlRequest: createWindowRequest.request);
                return true;
              },
              shouldOverrideUrlLoading: (controller, navAction) async {
                final nextUrl = navAction.request.url?.toString() ?? '';
                await _handleUrl(nextUrl, ref);
                return NavigationActionPolicy.ALLOW;
              },
              onLoadStart: (controller, url) async {
                final onLoadUrl = url?.toString() ?? '';
                await _handleUrl(onLoadUrl, ref);
                setState(() {
                  _isLoading = true;
                });
              },
              onLoadStop: (controller, url) async {
                final onStopUrl = url?.toString() ?? '';
                await _handleUrl(onStopUrl, ref);
                if ((onStopUrl.isEmpty || onStopUrl == 'about:blank') && widget.webPaymentScreenAr.paymentUrl.isNotEmpty) {
                  await _webViewController.loadUrl(
                    urlRequest: URLRequest(url: WebUri(widget.webPaymentScreenAr.paymentUrl)),
                  );
                }
                setState(() {
                  _isLoading = false;
                });
              },
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  void _buildRouting() {
    Navigator.of(context).pop();
  }

  Future<void> _handleUrl(String url, WidgetRef ref) async {
    final u = url.toLowerCase();
    if (u.contains('order-payment/success') || u.contains('payment/success') || u.contains('sale/payment/success')) {
      _buildRouting();
      final pdf = await ref.read(loadInvoicePdfController).loadInvoicePdf(orderId: widget.webPaymentScreenAr.orderId!);
      if (pdf != null) {
        ContextLess.context.nav.pushNamed(Routes.pdfView, arguments: pdf);
      }
    } else if (u.contains('payment/fail') || u.contains('payment/cancel')) {
      _buildRouting();
    }
  }

  Future _buildPaymentDoneDialog() {
    return showDialog(
      context: ContextLess.context,
      builder: (_) => CustomDialog(
        title: 'paymentSuccess',
        des: 'paymentSuccessDes',
        assetName: 'assets/svgs/done_icon.svg',
        buttonText: 'close',
        callback: () {
          // Navigator.of(context).pop();
          ContextLess.context.nav.pop();
        },
      ),
    );
  }

  Future _buildPaymentFailedDialog(BuildContext context) {
    return showDialog(
      context: ContextLess.context,
      builder: (_) => CustomDialog(
        title: 'paymentFailed',
        des: 'paymentFailedDes',
        assetName: 'assets/svgs/cancel_icon.svg',
        buttonText: 'close',
        callback: () {
          ContextLess.context.nav.pop();
        },
      ),
    );
  }
}

class WebPaymentScreenArg {
  final int? orderId;
  final String paymentUrl;
  WebPaymentScreenArg({
    this.orderId,
    required this.paymentUrl,
  });
}
