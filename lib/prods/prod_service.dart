import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProdService {
  Future<dynamic> getSingleProd(nomeDoProduto) async {
    final response = await http.get(Uri.parse(
        'http://${dotenv.env["SERVER_IP"]}:8000/api/produtos/$nomeDoProduto'));

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
}
