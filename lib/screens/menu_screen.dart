// lib/screens/menu_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_provider.dart';
import '../theme/app_theme.dart';
import '../utils/storage_service.dart';
import 'category_screen.dart';
import 'game_screen.dart';
import 'settings_screen.dart';
import 'how_to_play_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late AnimationController _logoCtrl;
  late Animation<double> _logoScale, _logoFloat;

  @override
  void initState() {
    super.initState();
    _logoCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200))..repeat(reverse: true);
    _logoScale = Tween<double>(begin: 0.96, end: 1.04).animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.easeInOut));
    _logoFloat = Tween<double>(begin: -7, end: 7).animate(CurvedAnimation(parent: _logoCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _logoCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final coins = StorageService.getCoins();
    final stars = StorageService.getTotalStars();
    final blitzBest = StorageService.getBlitzHighScore();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: SafeArea(child: Stack(children: [
          // Decorative circles
          Positioned(left: size.width*0.05, top: 50, child: _bubble(70, AppTheme.primary)),
          Positioned(left: size.width*0.80, top: 30, child: _bubble(45, AppTheme.secondary)),
          Positioned(left: size.width*0.08, top: size.height*0.72, child: _bubble(55, AppTheme.purple)),
          Positioned(left: size.width*0.82, top: size.height*0.60, child: _bubble(38, AppTheme.accent)),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(children: [
                const SizedBox(height: 14),
                // Top bar
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  _chip('⭐', stars.toString()),
                  _chip('🪙', coins.toString()),
                ]),
                const SizedBox(height: 30),
                // Logo
                AnimatedBuilder(animation: _logoCtrl, builder: (_,__) => Transform.translate(
                  offset: Offset(0, _logoFloat.value),
                  child: Transform.scale(scale: _logoScale.value, child: Column(children: [
                    Container(
                      width: 120, height: 120,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(34),
                        boxShadow: AppTheme.buttonShadow(AppTheme.primary),
                      ),
                      child: const Center(child: Text('⚡', style: TextStyle(fontSize: 62))),
                    ),
                    const SizedBox(height: 18),
                    RichText(textAlign: TextAlign.center, text: TextSpan(
                      style: const TextStyle(fontFamily:'Nunito', fontSize: 42, height: 1.1),
                      children: [
                        TextSpan(text: 'LexB', style: const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w800)),
                        TextSpan(text: 'litz', style: const TextStyle(color: Color(0xFF00D9FF), fontWeight: FontWeight.w800)),
                      ],
                    )),
                    const SizedBox(height: 6),
                    Text('Race the clock · 3,000+ words · 21 categories', textAlign: TextAlign.center,
                      style: const TextStyle(fontFamily:'Nunito', fontSize:14, color: AppTheme.textMedium, fontWeight: FontWeight.w600)),
                  ])),
                )),
                const SizedBox(height: 36),
                _modeCard(context, emoji:'🧩', title:'Classic', subtitle:'Pick a category, unscramble 100 words', gradient: AppTheme.classicGradient,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoryScreen()))),
                const SizedBox(height: 14),
                _modeCard(context, emoji:'⛓', title:'Chain', subtitle:'Each word connects — last letter starts the next', gradient: AppTheme.chainGradient,
                  onTap: () { context.read<GameProvider>().startChainMode(); Navigator.push(context, MaterialPageRoute(builder: (_) => const GameScreen())); }),
                const SizedBox(height: 14),
                _modeCard(context, emoji:'⚡', title:'Blitz', subtitle:'60 seconds — solve as many as you can!', gradient: AppTheme.blitzGradient,
                  bottom: blitzBest > 0 ? Text('Best: $blitzBest pts', style: const TextStyle(fontFamily:'Nunito', fontSize:13, color: Colors.white70)) : null,
                  onTap: () { context.read<GameProvider>().startBlitzMode(); Navigator.push(context, MaterialPageRoute(builder: (_) => const GameScreen())); }),
                const SizedBox(height: 28),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _iconBtn(Icons.help_outline_rounded, () => Navigator.push(context, MaterialPageRoute(builder:(_) => const HowToPlayScreen()))),
                  const SizedBox(width: 20),
                  _iconBtn(Icons.settings_rounded, () => Navigator.push(context, MaterialPageRoute(builder:(_) => const SettingsScreen()))),
                ]),
                const SizedBox(height: 30),
              ]),
            ),
          ),
        ])),
      ),
    );
  }

  Widget _bubble(double d, Color c) => Container(width:d, height:d, decoration:BoxDecoration(color:c.withOpacity(0.08), shape:BoxShape.circle));
  Widget _chip(String icon, String value) => Container(
    padding: const EdgeInsets.symmetric(horizontal:14, vertical:8),
    decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppTheme.primary.withOpacity(0.3))),
    child: Row(children: [Text(icon, style:const TextStyle(fontSize:16)), const SizedBox(width:6),
      Text(value, style:const TextStyle(fontFamily:'Nunito',fontSize:18,fontWeight:FontWeight.w800,color:AppTheme.textDark))]),
  );
  Widget _iconBtn(IconData icon, VoidCallback onTap) => GestureDetector(onTap:onTap,
    child: Container(width:48, height:48, decoration:BoxDecoration(color:AppTheme.primary.withOpacity(0.12), borderRadius:BorderRadius.circular(16), border:Border.all(color:AppTheme.primary.withOpacity(0.3))),
      child: Icon(icon, color: AppTheme.primary, size: 24)));
  Widget _modeCard(BuildContext ctx, {required String emoji, required String title, required String subtitle, required Gradient gradient, required VoidCallback onTap, Widget? bottom}) =>
    GestureDetector(onTap:onTap, child: Container(
      width: double.infinity, padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(gradient:gradient, borderRadius:BorderRadius.circular(22), boxShadow:[BoxShadow(color:Colors.black.withOpacity(0.2),blurRadius:16,offset:const Offset(0,6))]),
      child: Row(children: [
        Container(width:58, height:58, decoration:BoxDecoration(color:Colors.white.withOpacity(0.18), borderRadius:BorderRadius.circular(16)),
          child: Center(child: Text(emoji, style:const TextStyle(fontSize:30)))),
        const SizedBox(width:16),
        Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
          Text(title, style:const TextStyle(fontFamily:'Nunito',fontSize:22,fontWeight:FontWeight.w800,color:Colors.white)),
          Text(subtitle, style:const TextStyle(fontFamily:'Nunito',fontSize:13,color:Colors.white70)),
          if (bottom != null) ...[const SizedBox(height:4), bottom],
        ])),
        const Icon(Icons.arrow_forward_ios_rounded, color:Colors.white60, size:18),
      ]),
    ));
}
