import 'package:cryptocurrencies/repositories/favotiras_repository.dart';
import 'package:flutter/material.dart';
import 'meu_aplicativo.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritasRepository(),
      child: MeuAplicativo(),
    ),
  );
}
