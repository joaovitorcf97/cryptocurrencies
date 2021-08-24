import 'package:cryptocurrencies/repositories/favotiras_repository.dart';
import 'package:cryptocurrencies/widgets/moeda_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritasPage extends StatefulWidget {
  const FavoritasPage({Key? key}) : super(key: key);

  @override
  _FavoritasPageState createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritas'),
      ),
      body: Container(
        //color: Colors.indigo.withOpacity(0.5),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16),
        child: Consumer<FavoritasRepository>(
          builder: (context, favoritas, child) {
            return favoritas.lista.isEmpty
                ? Center(
                    child: Text('Ainda não há moedas favoritas'),
                  )
                : ListView.builder(
                    itemCount: favoritas.lista.length,
                    itemBuilder: (_, index) {
                      return MoedaCard(moeda: favoritas.lista[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}
