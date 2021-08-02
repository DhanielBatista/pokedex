import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> controlePokeApi(String pokeLimite) async {
  String apiUrl = 'https://pokeapi.co/api/v2/pokemon?limit=$pokeLimite';
  http.Response response = await http.get(Uri.parse(apiUrl));
  return json.decode(response.body);
}

Future<Map> pokeListaInicial(String apiUrl) async {
  http.Response response = await http.get(Uri.parse(apiUrl));
  return json.decode(response.body);
}
