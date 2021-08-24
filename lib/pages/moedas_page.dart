import 'package:cryptocurrencies/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';

class MoedasPage extends StatelessWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabela = MoedaRepository.tabela;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Crypto Currencies',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          return ListTile(
            leading: Image.asset(tabela[moeda].icone),
            title: Text(tabela[moeda].nome),
            trailing: Text(tabela[moeda].preco.toString()),
          );
        },
        separatorBuilder: (_, __) => Divider(),
        padding: EdgeInsets.all(16),
        itemCount: tabela.length,
      ),
    );
  }
}
