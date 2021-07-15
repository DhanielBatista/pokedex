import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> controlePokeApi(String pokeLimite) async {
  pokeLimite = pokeLimite.isEmpty ? '100' : pokeLimite;
  String apiUrl = 'https://pokeapi.co/api/v2/pokemon?limit=$pokeLimite';
  http.Response response = await http.get(Uri.parse(apiUrl));
  print(response);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Falhou');
  }
}

Future<Map> informacoesSobrePoke(String apiUrl) async {
  http.Response response = await http.get(Uri.parse(apiUrl));
  print(response);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Falhou');
  }
}
