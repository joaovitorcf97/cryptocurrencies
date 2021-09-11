import 'package:cryptocurrencies/configs/app_settings.dart';
import 'package:cryptocurrencies/models/moeda.dart';
import 'package:cryptocurrencies/pages/moedas_detalhes_page.dart';
import 'package:cryptocurrencies/repositories/favotiras_repository.dart';
import 'package:cryptocurrencies/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  _MoedasPageState createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  late NumberFormat real;
  late Map<String, String> loc;
  List<Moeda> selecionadas = [];
  late FavoritasRepository favoritas;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
      icon: Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.swap_vert),
            title: Text('Usar $locale'),
            onTap: () {
              context.read<AppSettings>().setLocate(locale, name);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text('Crypto Currencies'),
        centerTitle: true,
        actions: [
          changeLanguageButton(),
        ],
      );
    } else {
      return AppBar(
        elevation: 0,
        title: Text('${selecionadas.length} selecionadas'),
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

  monstrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MoedasDetalhesPage(moeda: moeda),
      ),
    );
  }

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    favoritas = context.watch<FavoritasRepository>();

    readNumberFormat();

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
            title: Row(
              children: [
                Text(
                  tabela[moeda].nome,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (favoritas.lista
                    .any((fav) => fav.sigla == tabela[moeda].sigla))
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.circle,
                      color: Colors.amber,
                      size: 8,
                    ),
                  ),
              ],
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
            onTap: () => monstrarDetalhes(tabela[moeda]),
          );
        },
        separatorBuilder: (_, __) => Divider(),
        padding: EdgeInsets.all(16),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favoritas.saveAll(selecionadas);
                limparSelecionadas();
              },
              icon: Icon(Icons.star),
              label: Text(
                'Favoritar',
                style: TextStyle(letterSpacing: 0, fontWeight: FontWeight.bold),
              ),
            )
          : null,
    );
  }
}
