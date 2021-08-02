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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Pokedex',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Stack(
        children: [
          Container(child: widgetMostrarPokemons(_pesquisarPokemon)),
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
                  mainAxisExtent: 80.0,
                  crossAxisSpacing: 60.0,
                  childAspectRatio: 560.0),
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
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
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
                                      settings: RouteSettings(
                                          arguments: snapshot.data),
                                      builder: (context) =>
                                          InformacoesPokemon()),
                                )),
                      );
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
