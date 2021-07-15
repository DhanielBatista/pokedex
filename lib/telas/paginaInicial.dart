import 'package:flutter/material.dart';
import 'package:projeto_pokedex/telas/informacoesPokemon.dart';
import 'selecionarPokemon.dart';
import 'package:projeto_pokedex/apiControle/controlePokeApi.dart' as api;

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({Key? key}) : super(key: key);

  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  String _pokemonSelecionado = '';

  Future _abrirNovaTela(BuildContext context) async {
    Map? resultado = await Navigator.of(context)
        .push(new MaterialPageRoute<Map>(builder: (BuildContext context) {
      return new InformacoesPokemon();
    }));
    if (resultado != null && resultado.containsKey('pokemonPesquisado')) {
      setState(() {
        _pokemonSelecionado = resultado['pokemonPesquisado'];
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Pokedex',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        actions: [
          IconButton(
              onPressed: () => _abrirNovaTela(context),
              icon: Icon(Icons.menu_book_rounded, color: Colors.white)),
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              'assets/pokeBusto.png',
              color: Colors.grey.shade300,
            ),
          ),
          widgetMostrarPokemons(_pokemonSelecionado)
        ],
      ),
    );
  }

  Widget widgetMostrarPokemons(String pokeLimite) {
    var futureBuilder = FutureBuilder(
      future: api.controlePokeApi(pokeLimite),
      builder: ((BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          Map? pokemon = snapshot.data;

          return ListView.builder(
            itemCount: pokemon!['results'].length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Container(
                    child: Text('${pokemon['results'][index]['name']}'),
                  ),
                  Container()
                ],
              );
            },
          );
        } else {
          return Container();
        }
      }),
    );
    return futureBuilder;
  }
}
