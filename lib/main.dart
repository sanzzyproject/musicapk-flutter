import 'package:flutter/material.dart';
import 'package:sannmusic_apk/music_webview.dart';

void main() {
  runApp(const SannMusicApp());
}

class SannMusicApp extends StatelessWidget {
  const SannMusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SANN404 MUSIC',
      debugShowCheckedModeBanner: false, // Menghilangkan pita "DEBUG" di pojok kanan atas
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF121212), // Warna background gelap ala Spotify
        useMaterialDesign: true,
      ),
      home: const MusicWebViewScreen(),
    );
  }
}
