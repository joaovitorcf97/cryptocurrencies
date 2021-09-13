import 'package:cryptocurrencies/configs/app_settings.dart';
import 'package:cryptocurrencies/repositories/conta_repository.dart';
import 'package:cryptocurrencies/repositories/favotiras_repository.dart';
import 'package:cryptocurrencies/repositories/moeda_repository.dart';
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
        ChangeNotifierProvider(create: (context) => MoedaRepository()),
        ChangeNotifierProvider(
            create: (context) => ContaRepository(
                  moedas: context.read<MoedaRepository>(),
                )),
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(
            create: (context) => FavoritasRepository(
                  moedas: context.read<MoedaRepository>(),
                )),
      ],
      child: MeuAplicativo(),
    ),
  );
}
