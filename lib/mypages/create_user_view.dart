// import 'dart:convert';
import 'package:kulika/common/theme_helper.dart';
import 'package:kulika/prods/prod_model.dart';
import 'package:flutter/material.dart';
import 'package:kulika/users/user_model.dart';
// import 'package:http/http.dart' as http;

class CreateUserView extends StatefulWidget {
  const CreateUserView({super.key});

  @override
  State<CreateUserView> createState() => _CreateUserViewState();
}

class _CreateUserViewState extends State<CreateUserView> {
  String? _tipo;

  final TextEditingController _nomeTextFieldController =
      TextEditingController();
  final TextEditingController _senhaTextFieldController =
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
                  SizedBox(height: 40),
                  Icon(
                    Icons.person,
                    color: Colors.grey[300],
                    size: 140,
                  ),
                  SizedBox(height: 13),
                  Text(
                    "Cadastro de Utilizador",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Digite os dados do Utilizador",
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
                  SizedBox(height: 20),
                  Container(
                    child: TextField(
                      controller: _senhaTextFieldController,
                      obscureText: true,
                      decoration: ThemeHelper().textInputDecoration(
                          'Password', 'Enter your password'),
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    // child: TextFormField(
                    //   controller: _senhaTextFieldController,
                    //   style: TextStyle(
                    //     color: Theme.of(context).primaryColor,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    //   decoration: InputDecoration(
                    //     border: InputBorder.none,
                    //     prefixIcon: Icon(
                    //       Icons.password,
                    //       size: 30,
                    //     ),
                    //     labelText: "Senha",
                    //     labelStyle: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w800,
                    //     ),
                    //   ),
                    //   // keyboardType: TextInputType.number,
                    // ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 28,
                      hint: const Text("Seleccione Tipo de Utilizador"),
                      disabledHint: const Text("Seleccione Tipo"),
                      underline: const SizedBox(),
                      isExpanded: true,
                      value: _tipo,
                      onChanged: (newValue) {
                        setState(() {
                          _tipo = newValue.toString();
                        });
                      },
                      items: User.tipos.map((valueItem) {
                        return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem.toUpperCase()));
                      }).toList(),
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
                        if (_nomeTextFieldController.text.isNotEmpty &&
                            _tipo != null &&
                            _senhaTextFieldController.text.isNotEmpty) {
                          User user = User(
                            nome: _nomeTextFieldController.text.toLowerCase(),
                            tipo: _tipo!,
                            senha: _senhaTextFieldController.text,
                          );

                          // addProds(prod);
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
