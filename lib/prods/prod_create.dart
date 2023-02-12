import 'dart:convert';
import 'package:kulika/prods/prod_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:boxicons/boxicons.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future addProds(prod) async {
  final response = await http.post(
    Uri.parse('http://${dotenv.env["SERVER_IP"]}:8000/api/produtos'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode({
      'nome': prod.nome,
      'loja': prod.loja[0],
      'preco': prod.preco[0],
    }),
  );

  if (response.statusCode == 200) {
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON.
    return Prod.fromJson(jsonDecode(response.body));
  } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    print('response.statusCode: ${response.statusCode}');
  }
}

class ProdCreate extends StatefulWidget {
  const ProdCreate({super.key});

  @override
  State<ProdCreate> createState() => _ProdCreateState();
}

class _ProdCreateState extends State<ProdCreate> {
  String? _loja;

  final TextEditingController _nomeTextFieldController =
      TextEditingController();
  // final TextEditingController _lojaTextFieldController =
  //     TextEditingController();
  final TextEditingController _precoTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("kulika"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         Navigator.pop(context);
                  //       },
                  //       icon: Icon(
                  //         Icons.arrow_back,
                  //         size: 30,
                  //         color: Theme.of(context).primaryColor,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 40),
                  // ImageIcon(
                  //   AssetImage("images/img/logo.png"),
                  //   // color: Colors.red,
                  //   size: 24,
                  //   // Image.asset("assets/img/logo.png"),
                  // ),
                  Icon(
                    // Icons.store,
                    Boxicons.bx_package,
                    color: Colors.grey[300],
                    size: 140,
                  ),
                  SizedBox(height: 13),
                  Text(
                    "Cadastro de Produtos",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Digite os dados do produto",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[400],
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: _nomeTextFieldController,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.description,
                          size: 30,
                        ),
                        labelText: "Nome",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 20),
                  // Container(
                  //   child: TextFormField(
                  //     controller: _lojaTextFieldController,
                  //     style: TextStyle(
                  //       color: Theme.of(context).primaryColor,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       prefixIcon: Icon(
                  //         Icons.store,
                  //         size: 30,
                  //       ),
                  //       labelText: "Loja",
                  //       labelStyle: TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w800,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  Container(
                    child: DropdownButton(
                      // prefixIcon: const Icon(Boxicons.bx_store),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 28,
                      hint: const Text("Seleccione a Loja"),
                      disabledHint: const Text("Seleccione a Loja"),
                      underline: const SizedBox(),
                      isExpanded: true,
                      value: _loja,
                      onChanged: (newValue) {
                        setState(() {
                          _loja = newValue.toString();
                        });
                      },
                      // items: Prod.nomeDelojas.map((key, valueItem) {
                      //   return DropdownMenuItem(value: valueItem, child: Text(valueItem));
                      // }).toList(),

                      items: Prod.lojas.map((valueItem) {
                        return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem.toUpperCase()));
                      }).toList(),
                      // Prod.nomeDelojas.map((valueItem) {
                      //   return DropdownMenuItem(value: valueItem, child: Text(valueItem));
                      // }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: TextFormField(
                      controller: _precoTextFieldController,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.price_check,
                          size: 30,
                        ),
                        labelText: "Preço",
                        labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      // keyboardType: TextInputType.numberWithOptions(
                      //   decimal: true,
                      // ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // var nomeCapitalized =
                        //     "${_nomeTextFieldController.text[0].toUpperCase()}${_nomeTextFieldController.text.substring(1)}";

                        if (_nomeTextFieldController.text.isNotEmpty &&
                            _loja != null &&
                            _precoTextFieldController.text.isNotEmpty) {
                          Prod prod = Prod(
                            nome: _nomeTextFieldController.text.toLowerCase(),
                            loja: [_loja!],
                            preco: [
                              double.parse(_precoTextFieldController.text)
                            ],
                          );

                          addProds(prod);
                        } else
                          print('cadastro falhou...');

                        Navigator.pop(context);
                      },
                      child: Text("Salvar"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
