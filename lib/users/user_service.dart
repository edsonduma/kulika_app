import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  static Future<dynamic> getData(user) async {
    // print('MY_IP: ${dotenv.env['SERVER_IP']}');

    final response = await http.put(
      Uri.parse('http://${dotenv.env["SERVER_IP"]}:8000/api/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'nome': user.nome,
        'senha': user.senha,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('response.statusCode: ${response.statusCode}');
    }
  }

  static Future setData(user) async {
    // print('SERVER IP: ${dotenv.env["SERVER_IP"]}');

    final response = await http.post(
      Uri.parse('http://${dotenv.env["SERVER_IP"]}:8000/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'nome': user.nome,
        'senha': user.senha,
        'tipo': user.tipo,
      }),
    );

    if (response.statusCode == 200) {
      //   // If the server did return a 200 OK response,
      //   // then parse the JSON.
      // print('object: ${response.body}, ${jsonDecode(response.body)}');
      return jsonDecode(response.body);
    } else {
      //   // If the server did not return a 200 OK response,
      //   // then throw an exception.
      print('response.statusCode: ${response.statusCode}');
    }
  }
}
