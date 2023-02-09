import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kulika/common/theme_helper.dart';
import 'package:kulika/common/util_service.dart';
import 'package:kulika/pages/login_page.dart';
import 'package:kulika/pages/profile_page.dart';
import 'package:kulika/pages/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kulika/users/user_model.dart';
import 'package:kulika/users/user_service.dart';

// import 'profile_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  String? _tipo;

  final TextEditingController _nomeTextFieldController =
      TextEditingController();
  final TextEditingController _senhaTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 70),
                        Text(
                          'kulika',
                          style: TextStyle(
                              fontSize: 60, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30),
                        Container(
                          child: TextFormField(
                            controller: _nomeTextFieldController,
                            decoration: ThemeHelper().textInputDecoration(
                                'Nome de Utilizador', 'Digite o seu nome'),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Por favor, insira o seu nome";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: TextFormField(
                            controller: _senhaTextFieldController,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Senha*", "Digite a sua senha"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Por favor, insira sua senha";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                        SizedBox(height: 15.0),
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
                                      "Aceito todos os termos e condições.",
                                      style: TextStyle(color: Colors.grey),
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
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'É necessário aceitar os termos e condições';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Cadastrar".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Navigator.of(context).pushAndRemoveUntil(
                                //     MaterialPageRoute(
                                //         builder: (context) => ProfilePage()),
                                //     (Route<dynamic> route) => false);

                                // if (_nomeTextFieldController.text.isNotEmpty &&
                                //     _tipo != null &&
                                //     _senhaTextFieldController.text.isNotEmpty) {
                                User user = User(
                                  nome: _nomeTextFieldController.text
                                      .toLowerCase(),
                                  tipo: _tipo!,
                                  senha: _senhaTextFieldController.text,
                                );

                                UserService.setData(user);

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                    (Route<dynamic> route) => false);
                              } else
                                print('cadastro falhou...');
                            },
                          ),
                        ),
                        SizedBox(height: 30.0),
                        // Text(
                        //   "Or create account using social media",
                        //   style: TextStyle(color: Colors.grey),
                        // ),
                        // SizedBox(height: 25.0),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     GestureDetector(
                        //       child: FaIcon(
                        //         FontAwesomeIcons.googlePlus,
                        //         size: 35,
                        //         color: HexColor("#EC2D2F"),
                        //       ),
                        //       onTap: () {
                        //         setState(() {
                        //           showDialog(
                        //             context: context,
                        //             builder: (BuildContext context) {
                        //               return ThemeHelper().alartDialog(
                        //                   "Google Plus",
                        //                   "You tap on GooglePlus social icon.",
                        //                   context);
                        //             },
                        //           );
                        //         });
                        //       },
                        //     ),
                        //     SizedBox(
                        //       width: 30.0,
                        //     ),
                        //     GestureDetector(
                        //       child: Container(
                        //         padding: EdgeInsets.all(0),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(100),
                        //           border: Border.all(
                        //               width: 5, color: HexColor("#40ABF0")),
                        //           color: HexColor("#40ABF0"),
                        //         ),
                        //         child: FaIcon(
                        //           FontAwesomeIcons.twitter,
                        //           size: 23,
                        //           color: HexColor("#FFFFFF"),
                        //         ),
                        //       ),
                        //       onTap: () {
                        //         setState(() {
                        //           showDialog(
                        //             context: context,
                        //             builder: (BuildContext context) {
                        //               return ThemeHelper().alartDialog(
                        //                   "Twitter",
                        //                   "You tap on Twitter social icon.",
                        //                   context);
                        //             },
                        //           );
                        //         });
                        //       },
                        //     ),
                        //     SizedBox(
                        //       width: 30.0,
                        //     ),
                        //     GestureDetector(
                        //       child: FaIcon(
                        //         FontAwesomeIcons.facebook,
                        //         size: 35,
                        //         color: HexColor("#3E529C"),
                        //       ),
                        //       onTap: () {
                        //         setState(() {
                        //           showDialog(
                        //             context: context,
                        //             builder: (BuildContext context) {
                        //               return ThemeHelper().alartDialog(
                        //                   "Facebook",
                        //                   "You tap on Facebook social icon.",
                        //                   context);
                        //             },
                        //           );
                        //         });
                        //       },
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
