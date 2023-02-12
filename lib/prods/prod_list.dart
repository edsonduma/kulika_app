import 'dart:convert';
import 'package:kulika/prods/prod_create.dart';
import 'package:kulika/prods/prod_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kulika/prods/prod_details.dart';
import 'package:kulika/prods/prod_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kulika/users/user_model.dart';

Future<dynamic> getProds() async {
  final response = await http
      .get(Uri.parse('http://${dotenv.env["SERVER_IP"]}:8000/api/produtos'));

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

class ProdList extends StatefulWidget {
  final User userLogged;

  // const ProdList({super.key});
  const ProdList({Key? key, required this.userLogged}) : super(key: key);

  @override
  State<ProdList> createState() => _ProdListState();
}

class _ProdListState extends State<ProdList> {
  final TextEditingController searchController = TextEditingController();
  late List<Prod> myProdList = [];
  late List<Prod> items = [];

  final sizeOfLogo = 18.0;

  @override
  void initState() {
    super.initState();

    getAllProds();
  }

  Future<List<Prod>> getAllProds() async {
    setState(() => items.clear());
    var json = await getProds();

    myProdList = [];
    Prod temp = Prod(nome: '', loja: [], preco: []);

    for (var item in json['data']) {
      // print('string: $item:' + temp.nome);

      if (item['nome'] == temp.nome) {
        temp.loja.add(item['loja']);
      } else {
        temp = Prod(
          nome: item['nome'],
          loja: [item['loja']],
          preco: [double.parse(item['preco'])],
        );

        myProdList.add(temp);
      }
    }

    setState(() => items.addAll(myProdList));

    // print("finalizando a solicitacao...");

    return Future.value(myProdList);
  }

  void filterSearchResults(String query) {
    List dummySearchList = [];
    dummySearchList.addAll(myProdList);
    // print(myProdList);

    if (query.isNotEmpty) {
      List<Prod> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.nome.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(myProdList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("kulika"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: items.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: getAllProds,
              child: ListView(
                children: [
                  SizedBox(height: 10),
                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    decoration: InputDecoration(
                        labelText: "Pesquisar",
                        hintText: "Pesquisar por produto...",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)))),
                  ),
                  SizedBox(height: 10),
                  // Container(
                  //   // margin: EdgeInsets.all(10),
                  //   margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  //   child: Card(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //       //set border radius more than 50% of height and width to make circle
                  //     ),
                  //     elevation: 10,
                  //     child: ListTile(
                  //       leading: CircleAvatar(
                  //         child: Text(
                  //           'T',
                  //         ),
                  //         backgroundColor: Theme.of(context).primaryColor,
                  //         foregroundColor: Colors.white,
                  //       ),
                  //       title: Text(
                  //         'TESTE',
                  //         style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 30,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       subtitle: Text(
                  //         '100 kz',
                  //         style: TextStyle(
                  //           color: Colors.green,
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       trailing: Container(
                  //         width: 120,
                  //         height: 120,
                  //         padding: const EdgeInsets.symmetric(vertical: 4.0),
                  //         alignment: Alignment.centerRight,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: [
                  //             CircleAvatar(
                  //               child: Image.asset(
                  //                 'assets/' + Prod.getImg('shoprite'.toLowerCase()),
                  //                 width: 50,
                  //                 height: 50,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //               radius: 18,
                  //             ),
                  //             SizedBox(width: 5),
                  //             CircleAvatar(
                  //               child: Image.asset(
                  //                 'assets/' + Prod.getImg('kero'.toLowerCase()),
                  //                 width: 50,
                  //                 height: 50,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //               radius: 18,
                  //             ),
                  //             SizedBox(width: 5),
                  //             CircleAvatar(
                  //               child: Image.asset(
                  //                 'assets/' + Prod.getImg('maxi'.toLowerCase()),
                  //                 width: 50,
                  //                 height: 50,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //               radius: 18,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  ...items.map((Prod prod) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProdDetails(prodItem: prod),
                          ),
                        );
                      },
                      child: Container(
                        // margin: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            //set border radius more than 50% of height and width to make circle
                          ),
                          elevation: 10,
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                prod.nome[0],
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                            ),
                            title: Text(
                              prod.nome,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              prod.preco[0].toString() + ' kz',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // trailing: Text(
                            //   prod.loja.toUpperCase(),
                            //   style: TextStyle(
                            //       color: Colors.black,
                            //       fontSize: 20,
                            //       fontWeight: FontWeight.bold),
                            // ),
                            // trailing: CircleAvatar(
                            //   backgroundImage: AssetImage(
                            //     'assets/' + prod.loja.toLowerCase() + '.png',
                            //   ),
                            //   // child: Image.asset(
                            //   //   'assets/' + prod.loja.toLowerCase() + '.png',
                            //   // ),
                            // ),
                            // trailing: ClipOval(
                            //   child: Image.asset(
                            //     'assets/' + prod.loja.toLowerCase() + '.png',
                            //     width: 100,
                            //     height: 100,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            // trailing: Row(
                            //   children: [
                            //     ...prod.loja.map((lojaItem) {
                            //       return CircleAvatar(
                            //         // backgroundImage: AssetImage(
                            //         //   'assets/' + prod.loja.toLowerCase() + '.png',
                            //         // ),
                            //         // child: Image.asset(
                            //         //   'assets/' + prod.loja.toLowerCase() + '.png',
                            //         // ),
                            //         child: Image.asset(
                            //           // 'assets/' + prod.loja.toLowerCase() + '.png',
                            //           'assets/' + Prod.getImg(lojaItem.toLowerCase()),
                            //           width: 10,
                            //           height: 10,
                            //           fit: BoxFit.cover,
                            //         ),
                            //       );
                            //     })
                            //   ],
                            // ),
                            // trailing: CircleAvatar(
                            //   child: Image.asset(
                            //     'assets/' + Prod.getImg(prod.loja[0].toLowerCase()),
                            //     width: 50,
                            //     height: 50,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            trailing: Container(
                              width: 125,
                              height: 125,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ...prod.loja.map((lojaItem) {
                                    return Wrap(
                                      // spacing: 5,
                                      children: [
                                        CircleAvatar(
                                          child: Image.asset(
                                            'assets/' +
                                                Prod.getImg(
                                                    lojaItem.toLowerCase()),
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                          radius: 18,
                                        ),
                                        SizedBox(width: 5)
                                      ],
                                    );
                                    // return CircleAvatar(
                                    //   child: Image.asset(
                                    //     'assets/' + Prod.getImg(lojaItem.toLowerCase()),
                                    //     width: 50,
                                    //     height: 50,
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    //   radius: 18,
                                    // );
                                  }),
                                  // CircleAvatar(
                                  //   child: Image.asset(
                                  //     'assets/' + Prod.getImg('shoprite'.toLowerCase()),
                                  //     width: 50,
                                  //     height: 50,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  //   radius: 18,
                                  // ),
                                  // SizedBox(width: 5),
                                  // CircleAvatar(
                                  //   child: Image.asset(
                                  //     'assets/' + Prod.getImg('kero'.toLowerCase()),
                                  //     width: 50,
                                  //     height: 50,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  //   radius: 18,
                                  // ),
                                  // SizedBox(width: 5),
                                  // CircleAvatar(
                                  //   child: Image.asset(
                                  //     'assets/' + Prod.getImg('maxi'.toLowerCase()),
                                  //     width: 50,
                                  //     height: 50,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  //   radius: 18,
                                  // ),
                                ],
                              ),
                            ),
                            //   trailing: Container(
                            //   width: 120,
                            //   height: 120,
                            //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                            //   alignment: Alignment.centerLeft,
                            //   child: Row(
                            //     children: [
                            //       CircleAvatar(
                            //         child: Image.asset(
                            //           'assets/' + Prod.getImg('shoprite'.toLowerCase()),
                            //           width: 50,
                            //           height: 50,
                            //           fit: BoxFit.cover,
                            //         ),
                            //         radius: 18,
                            //       ),
                            //       SizedBox(width: 5),
                            //       CircleAvatar(
                            //         child: Image.asset(
                            //           'assets/' + Prod.getImg('kero'.toLowerCase()),
                            //           width: 50,
                            //           height: 50,
                            //           fit: BoxFit.cover,
                            //         ),
                            //         radius: 18,
                            //       ),
                            //       SizedBox(width: 5),
                            //       CircleAvatar(
                            //         child: Image.asset(
                            //           'assets/' + Prod.getImg('maxi'.toLowerCase()),
                            //           width: 50,
                            //           height: 50,
                            //           fit: BoxFit.cover,
                            //         ),
                            //         radius: 18,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 80)
                ],
              ),
            ),
      floatingActionButton: (widget.userLogged.tipo == 'super_admin' &&
              widget.userLogged.tipo == 'admin_loja'
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProdCreate(),
                  ),
                ).then((_) => getAllProds());
              },
              tooltip: "Adicionar Produto",
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
            )
          : null),
    );
  }
}
