import 'package:kulika/prods/prod_model.dart';
import 'package:kulika/prods/prod_service.dart';
import 'package:flutter/material.dart';
import 'package:boxicons/boxicons.dart';

class ProdDetails extends StatefulWidget {
  final Prod prodItem;

  // const ProdDetails({
  //   super.key,
  //   required this.prodItem,
  // });
  const ProdDetails({Key? key, required this.prodItem}) : super(key: key);

  @override
  State<ProdDetails> createState() => _ProdDetailsState();
}

class _ProdDetailsState extends State<ProdDetails> {
  late Prod _futureProdItem = Prod(nome: '', loja: [], preco: []);

  @override
  void initState() {
    super.initState();

    getSingleProducts();
  }

  Future<Prod> getSingleProducts() async {
    var json = await ProdService().getSingleProd(widget.prodItem.nome);

    var myPrecos = [];
    for (var item in json['data']['preco']) {
      myPrecos.add(double.parse(item));
    }

    setState(
      () => _futureProdItem = Prod(
        nome: json['data']['nome'],
        loja: List<String>.from(json['data']['loja']),
        preco: List<double>.from(myPrecos),
      ),
    );

    return Future.value(_futureProdItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("kulika"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _futureProdItem.loja.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: getSingleProducts,
              child: Padding(
                padding: EdgeInsets.all(25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Icon(
                        Boxicons.bxs_package,
                        color: Colors.grey[300],
                        size: 140,
                      ),
                      SizedBox(height: 13),
                      Text(
                        _futureProdItem.nome,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      ..._futureProdItem.loja
                          .asMap()
                          .entries
                          .map((singleStore) {
                        return Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              //set border radius more than 50% of height and width to make circle
                            ),
                            elevation: 10,
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image.asset(
                                  'assets/' +
                                      Prod.getImg(
                                          singleStore.value.toLowerCase()),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                radius: 18,
                              ),
                              title: Text(
                                singleStore.value,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                this
                                        ._futureProdItem
                                        .preco[singleStore.key]
                                        .toString() +
                                    ' kz',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                // ),
              ),
            ),
    );
  }
}
