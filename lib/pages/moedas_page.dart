import 'package:cryptocurrencies/modules/moeda.dart';
import 'package:cryptocurrencies/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  _MoedasPageState createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt-BR', name: 'R\$');
  List<Moeda> selecionadas = [];

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text('Crypto Currencies'),
        centerTitle: true,
      );
    } else {
      return AppBar(
        elevation: 0,
        title: Text('${selecionadas.length} moedas selecionadas'),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.black),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          return ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            leading: (selecionadas.contains(tabela[moeda]))
                ? CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    width: 40,
                    child: Image.asset(tabela[moeda].icone),
                  ),
            title: Text(
              tabela[moeda].nome,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              real.format(tabela[moeda].preco),
            ),
            selected: selecionadas.contains(tabela[moeda]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[moeda]))
                    ? selecionadas.remove(tabela[moeda])
                    : selecionadas.add(tabela[moeda]);
              });
            },
          );
        },
        separatorBuilder: (_, __) => Divider(),
        padding: EdgeInsets.all(16),
        itemCount: tabela.length,
      ),
    );
  }
}
