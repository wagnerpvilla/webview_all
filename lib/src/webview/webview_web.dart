// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

class WebviewWeb extends StatefulWidget {
  final String? url;
  final String? html;

  const WebviewWeb({
    Key? key,
    this.url,
    this.html,
  }) : super(key: key);

  @override
  State<WebviewWeb> createState() => _WebviewWebState();
}

class _WebviewWebState extends State<WebviewWeb> {
  _WebviewWebState();

  @override
  void initState() {
    super.initState();
    WebViewPlatform.instance = WebWebViewPlatform();
  }

  @override
  Widget build(BuildContext context) {
    assert(() {
      if (widget.url == null && widget.html == null) {
        throw FlutterError('Either url or html must be provided');
      }

      return true;
    }());

    final PlatformWebViewController controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    );

    if (widget.url != null) {
      controller.loadRequest(
        LoadRequestParams(
          uri: Uri.parse(widget.url!),
        ),
      );
    } else if (widget.html != null) {
      controller.loadHtmlString(widget.html!);
    }

    return PlatformWebViewWidget(
      PlatformWebViewWidgetCreationParams(controller: controller),
    ).build(context);
  }
}
