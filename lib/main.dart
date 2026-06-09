// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'models/game_provider.dart';
import 'theme/app_theme.dart';
import 'utils/storage_service.dart';
import 'utils/audio_service.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await StorageService.init();
  await AudioService.init();
  runApp(const LexBlitzApp());
}

class LexBlitzApp extends StatelessWidget {
  const LexBlitzApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: MaterialApp(
        title: 'LexBlitz',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const SplashScreen(),
      ),
    );
  }
}
