import 'package:flutter/material.dart';
import 'package:projeto_pokedex/apiControle/controlePokeApi.dart';

class InformacoesPokemon extends StatefulWidget {
  const InformacoesPokemon({Key? key}) : super(key: key);

  @override
  _InformacoesPokemonState createState() => _InformacoesPokemonState();
}

class _InformacoesPokemonState extends State<InformacoesPokemon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pokedex',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 50, 30, 50),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('PokemonNome',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(240, 50, 30, 50),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('#PokeNum',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 90, 30, 50),
            decoration: BoxDecoration(
                color: Colors.grey.shade400,
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.all(Radius.circular(88.0))),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Tipo',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 290, 0, 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
          ),
        ],
      ),
    );
  }
}
