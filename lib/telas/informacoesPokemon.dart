import 'package:flutter/material.dart';
import 'package:projeto_pokedex/Controle/controlePokeApi.dart' as api;

class InformacoesPokemon extends StatefulWidget {
  const InformacoesPokemon({Key? key}) : super(key: key);

  @override
  _InformacoesPokemonState createState() => _InformacoesPokemonState();
}

class _InformacoesPokemonState extends State<InformacoesPokemon> {
  @override
  Widget build(BuildContext context) {
    final pokemonSelecionado =
        ModalRoute.of(context)!.settings.arguments as dynamic;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pokedex',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.red,
      ),
      body: Stack(children: [
        Container(
          margin: EdgeInsets.fromLTRB(110, 110, 0, 0),
          child: Image.asset('assets/pokeballFundo.png',
              color: Colors.grey.shade400, width: 200.0),
        ),
        Container(
          child: widgetMostrarPokeSelecionado(pokemonSelecionado),
        )
      ]),
    );
  }

  List<Widget> _pokeTipos(dynamic pokemonSelecionado) {
    List<Widget> widgets = [];
    for (var type in pokemonSelecionado['types']) {
      var widget = Container(
        margin: EdgeInsets.fromLTRB(5, 60, 5, 50),
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.all(Radius.circular(88.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${type['type']['name']}',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      );
      widgets.add(widget);
    }
    return widgets;
  }

  Widget widgetMostrarPokeSelecionado(dynamic pokemonSelecionado) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 30, 50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${pokemonSelecionado['name']}'.toUpperCase(),
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(290, 14, 30, 50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('#${pokemonSelecionado['id']}',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        Row(children: _pokeTipos(pokemonSelecionado)),
        Container(
          margin: EdgeInsets.fromLTRB(0, 290, 0, 0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              )),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(60, 90, 40, 90),
            child: Image.network(
              pokemonSelecionado['sprites']['other']['official-artwork']
                  ['front_default'],
              width: 290.0,
              height: 290.0,
            )),
        Container(
            margin: EdgeInsets.fromLTRB(60, 350, 40, 0),
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints.expand(height: 50),
                    child: TabBar(
                        indicatorColor: Colors.transparent,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.blue,
                        tabs: [
                          Tab(
                            text: ('Status'),
                          ),
                          Tab(
                            text: 'Bio',
                          ),
                          Tab(text: 'Info'),
                        ]),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: TabBarView(children: [
                        Container(
                          child: atualizarContainerStatus(pokemonSelecionado),
                        ),
                        Container(
                          child: atualizarContainerBio(pokemonSelecionado),
                        ),
                        Container(
                          child: atualizarContainerInfo(pokemonSelecionado),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  Widget atualizarContainerStatus(pokemonSelecionado) {
    return Column(
      children: [
        Container(
            alignment: Alignment.topLeft,
            child: Text('Status',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                "HP: ${pokemonSelecionado!['stats'][0]['base_stat']}",
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.topLeft,
              child:
                  Text("ATK: ${pokemonSelecionado!['stats'][1]['base_stat']}")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.topLeft,
              child:
                  Text("DEF: ${pokemonSelecionado!['stats'][2]['base_stat']}")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                  "SPECIAL - ATK: ${pokemonSelecionado!['stats'][3]['base_stat']}")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                  "SPECIAL - DEF: ${pokemonSelecionado!['stats'][4]['base_stat']}")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                  "SPEED: ${pokemonSelecionado!['stats'][5]['base_stat']}")),
        ),
      ],
    );
  }
}

Widget atualizarContainerBio(pokemonSelecionado) {
  return Column(
    children: [
      Container(
          alignment: Alignment.topLeft,
          child: Text('Bio',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold))),
      Container(
          child: FutureBuilder(
              future:
                  api.pokeListaInicial(pokemonSelecionado['species']['url']),
              builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                if (snapshot.hasData) {
                  Map? infoPokemon = snapshot.data;
                  var evolucaopokemon = infoPokemon!['evolves_from_species'];
                  if (infoPokemon['evolves_from_species'] == null) {
                    evolucaopokemon = 'None';
                  } else {
                    evolucaopokemon =
                        infoPokemon['evolves_from_species']['name'];
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                              'Habitat: ${infoPokemon['habitat']['name']}'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                              'Locomotion: ${infoPokemon['shape']['name']}'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text('Evolution From: $evolucaopokemon'),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              })),
    ],
  );
}

Widget atualizarContainerInfo(pokemonSelecionado) {
  return Column(
    children: [
      Container(
          alignment: Alignment.topLeft,
          child: Text('Info',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold))),
      Container(
          child: FutureBuilder(
              future:
                  api.pokeListaInicial(pokemonSelecionado['species']['url']),
              builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                if (snapshot.hasData) {
                  Map? infoPokemon = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${infoPokemon!['flavor_text_entries'][0]['flavor_text'].replaceAll('\n', ' ')}',
                            style: textStyle(),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${infoPokemon['flavor_text_entries'][2]['flavor_text'].replaceAll('\n', ' ')}',
                            style: textStyle(),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${infoPokemon['flavor_text_entries'][3]['flavor_text'].replaceAll('\n', ' ')}',
                            style: textStyle(),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              })),
    ],
  );
}

textStyle() {
  return TextStyle(fontSize: 15.0);
}
