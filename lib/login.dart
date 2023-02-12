import 'dart:convert';
import 'package:kulika/common/theme_helper.dart';
import 'package:kulika/mypages/create_user_view.dart';
import 'package:kulika/prods/prod_list.dart';
import 'package:kulika/prods/prod_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Future addProds(prod) async {
//   final response = await http.post(
//     Uri.parse('http://192.168.29.24:8000/api/produtos'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: json.encode({
//       'Nome do Utilizador': prod.Nome do Utilizador,
//       'loja': prod.loja[0],
//       'preco': prod.preco,
//     }),
//   );

//   if (response.statusCode == 200) {
//     //   // If the server did return a 200 OK response,
//     //   // then parse the JSON.
//     return Prod.fromJson(jsonDecode(response.body));
//   } else {
//     //   // If the server did not return a 200 OK response,
//     //   // then throw an exception.
//     print('response.statusCode: ${response.statusCode}');
//   }
// }

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  // String? _loja;
  // String? _user;
  // String? _pwd;

  final TextEditingController _userTextFieldController =
      TextEditingController();
  final TextEditingController _pwdTextFieldController = TextEditingController();

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
                  SizedBox(height: 13),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Por favor, insira os seus dados!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[400],
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: _userTextFieldController,
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
                        labelText: "Nome do Utilizador",
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
                      controller: _pwdTextFieldController,
                      obscureText: true,
                      decoration: ThemeHelper().textInputDecoration(
                          'Password', 'Enter your password'),
                    ),
                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    // child: TextFormField(
                    //   controller: _pwdTextFieldController,
                    //   style: TextStyle(
                    //     color: Theme.of(context).primaryColor,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    //   decoration: InputDecoration(
                    //     border: InputBorder.none,
                    //     prefixIcon: Icon(
                    //       Icons.price_check,
                    //       size: 30,
                    //     ),
                    //     labelText: "Senha",
                    //     labelStyle: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w800,
                    //     ),
                    //   ),
                    //   // keyboardType: TextInputType.numberWithOptions(
                    //   //   decimal: true,
                    //   // ),
                    //   // keyboardType: TextInputType.number,
                    // ),
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
                        if (_userTextFieldController.text == "admin" &&
                            _pwdTextFieldController.text == "admin") {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ProdList(),
                          //   ),
                          // );
                        }

                        _userTextFieldController.text = '';
                        _pwdTextFieldController.text = '';
                      },
                      child: Text("Aceder"),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateUserView(),
                          ),
                        );
                      },
                      child: Text("Cadastrar"),
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
