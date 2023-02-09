import 'dart:convert';
import 'package:http/http.dart' as http;

class ProdService {
  Future<dynamic> getSingleProd(nomeDoProduto) async {
    final response = await http
        .get(Uri.parse('http://10.0.12.89:8000/api/produtos/$nomeDoProduto'));

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
