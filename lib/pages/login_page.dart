import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kulika/common/theme_helper.dart';
import 'package:kulika/prods/prod_list.dart';
import 'package:kulika/users/user_model.dart';
import 'package:kulika/users/user_service.dart';

// import 'profile_page.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  // Key _formKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  bool checkboxValue = false;

  final TextEditingController _userTextFieldController =
      TextEditingController();
  final TextEditingController _pwdTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'kulika',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Digite as suas credenciais',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextField(
                                  controller: _userTextFieldController,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Nome de Utilizador',
                                      'Digite o seu nome'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextField(
                                  controller: _pwdTextFieldController,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Senha', 'Digite a sua senha'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              // SizedBox(height: 10.0),
                              FormField<bool>(
                                builder: (state) {
                                  return Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Checkbox(
                                              value: checkboxValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  checkboxValue = value!;
                                                  state.didChange(value);
                                                });
                                              }),
                                          Text(
                                            "Manter logado!",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          state.errorText ?? '',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Theme.of(context).errorColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                validator: (_) {
                                  if (_userTextFieldController.text == "" &&
                                      _pwdTextFieldController.text == "") {
                                    return 'É necessário preencher todos os campos!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 15.0),
                              // Container(
                              //   margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                              //   alignment: Alignment.topRight,
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 ForgotPasswordPage()),
                              //       );
                              //     },
                              //     child: Text(
                              //       "Esqueceu sua senha?",
                              //       style: TextStyle(
                              //         color: Colors.grey,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Entrar'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () async {
                                    //After successful login we will redirect to profile page. Let's create profile page now
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ProfilePage()));
                                    // print('por desenvolver...');

                                    // if (_userTextFieldController.text ==
                                    //         "admin" &&
                                    //     _pwdTextFieldController.text ==
                                    //         "admin") {
                                    //   _userTextFieldController.text = '';
                                    //   _pwdTextFieldController.text = '';

                                    if (_formKey.currentState!.validate()) {
                                      User user = User(
                                        nome: _userTextFieldController.text
                                            .toLowerCase(),
                                        senha: _pwdTextFieldController.text,
                                      );

                                      var isLoggedIn = false;

                                      var loginStatus =
                                          await UserService.getData(user);
                                      // print('status: ${loginStatus["data"]}');

                                      try {
                                        var logTeste =
                                            loginStatus["data"]["nome"];
                                        print(
                                            'logTeste: ${loginStatus["data"]}');
                                        isLoggedIn = true;
                                      } catch (e) {
                                        isLoggedIn = false;
                                      }

                                      if (isLoggedIn) {
                                        User userLogged = User(
                                          nome: '',
                                          senha: '',
                                          tipo: '',
                                        );
                                        ;
                                        try {
                                          userLogged = User(
                                            nome: loginStatus["data"]["nome"],
                                            tipo: loginStatus["data"]["tipo"],
                                          );
                                        } catch (e) {
                                          print('erro de conversao...');
                                        }
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProdList(
                                                  userLogged: userLogged)),
                                        );
                                      } else {
                                        print('login falhou...');

                                        _userTextFieldController.text = '';
                                        _pwdTextFieldController.text = '';
                                      }
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "Não tem uma conta? "),
                                  TextSpan(
                                    text: 'Crie',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             RegistrationPage()));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegistrationPage()));
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ])),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
