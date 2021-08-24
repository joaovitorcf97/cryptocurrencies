import 'package:cryptocurrencies/configs/app_settings.dart';
import 'package:cryptocurrencies/repositories/favotiras_repository.dart';
import 'package:flutter/material.dart';
import 'configs/hive_config.dart';
import 'meu_aplicativo.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(create: (context) => FavoritasRepository()),
      ],
      child: MeuAplicativo(),
    ),
  );
}
