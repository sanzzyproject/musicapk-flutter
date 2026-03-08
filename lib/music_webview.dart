import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MusicWebViewScreen extends StatefulWidget {
  const MusicWebViewScreen({super.key});

  @override
  State<MusicWebViewScreen> createState() => _MusicWebViewScreenState();
}

class _MusicWebViewScreenState extends State<MusicWebViewScreen> {
  late final WebViewController _controller;

  // URL Vercel Anda yang sudah aktif
  final String _pwaUrl = 'https://sannmusicplayer.vercel.app';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF121212)) // Background gelap mencegah layar putih saat loading
      ..setUserAgent("Mozilla/5.0 (Linux; Android 13; SANN404 Build/1.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Mobile Safari/537.36")
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {
            debugPrint('Error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            // Jika URL masih bagian dari web Anda, izinkan WebView memuatnya
            if (request.url.startsWith(_pwaUrl)) {
              return NavigationDecision.navigate;
            } else {
              // Jika URL menuju keluar (misal link WhatsApp/Github), buka di aplikasi luar
              _launchExternalUrl(request.url);
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(_pwaUrl));
  }

  Future<void> _launchExternalUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
       debugPrint('Gagal membuka $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
