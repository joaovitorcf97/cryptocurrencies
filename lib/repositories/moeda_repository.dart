import 'package:cryptocurrencies/models/moeda.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
      icone: 'images/bitcoin.png',
      nome: 'Bitcoin',
      sigla: 'BTC',
      preco: 10000.00,
    ),
    Moeda(
      icone: 'images/ethereum.png',
      nome: 'Ethereum',
      sigla: 'ETH',
      preco: 10000.00,
    ),
    Moeda(
      icone: 'images/cardano.png',
      nome: 'Cardano',
      sigla: 'ADA',
      preco: 10000.00,
    ),
    Moeda(
      icone: 'images/litecoin.png',
      nome: 'Litecoin',
      sigla: 'LTC',
      preco: 10000.00,
    ),
    Moeda(
      icone: 'images/usdcoin.png',
      nome: 'USD Coin',
      sigla: 'ESDC',
      preco: 10000.00,
    ),
    Moeda(
      icone: 'images/xrp.png',
      nome: 'XRP',
      sigla: 'XRP',
      preco: 10000.00,
    ),
  ];
}
