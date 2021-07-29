import 'package:flutter/material.dart';
import 'package:projeto_pokedex/telas/informacoesPokemon.dart';
import 'package:projeto_pokedex/Controle/controlePokeApi.dart' as api;

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({Key? key}) : super(key: key);

  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  String _pesquisarPokemon = '';

  Future _abrirTelaDePesquisa(BuildContext context) async {
    Map? resultado = await Navigator.of(context)
        .push(new MaterialPageRoute<Map>(builder: (BuildContext context) {
      return new InformacoesPokemon();
    }));
    if (resultado != null && resultado.containsKey('pokemonPesquisado')) {
      setState(() {
        _pesquisarPokemon = resultado['pokemonPesquisado'];
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
              onPressed: () => _abrirTelaDePesquisa(context),
              icon: Icon(Icons.search, color: Colors.white)),
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              'assets/pokeBusto.png',
              color: Colors.grey.shade300,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          widgetMostrarPokemons(_pesquisarPokemon)
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

          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: pokemon!['results'].length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder(
                  future:
                      api.pokeListaInicial(pokemon['results'][index]['url']),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<Map> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      return ListTile(
                          title: Image.network(
                            snapshot.data!['sprites']['other']
                                ['official-artwork']['front_default'],
                            width: 90,
                            height: 90,
                          ),
                          subtitle: Text(
                            '${pokemon['results'][index]['name']}'
                                .toUpperCase(),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings:
                                        RouteSettings(arguments: snapshot.data),
                                    builder: (context) => InformacoesPokemon()),
                              ));
                    } else {
                      return Container();
                    }
                  },
                );
              });
        } else {
          return Container();
        }
      }),
    );
    return futureBuilder;
  }
}
