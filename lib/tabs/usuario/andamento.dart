import 'package:app_vai/telas/showInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Andamento extends StatefulWidget {
  @override
  _AndamentoState createState() => _AndamentoState();
}

class _AndamentoState extends State<Andamento> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController resolucaoChamado  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection("chamados")
                  .where("status", isEqualTo: 3)
                  .orderBy("titulo")
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.done:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.data.documents.length == 0) {
                      return Center(
                        child: Text(
                          "Não há dados!",
                          style:
                          TextStyle(color: Colors.redAccent, fontSize: 20),
                        ),
                      );
                    }

                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        padding: EdgeInsets.only(
                            top: 5, left: 5, right: 5, bottom: 10),
                        itemBuilder: (context, index) {
                          return Card(
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                        snapshot.data.documents[index].data["titulo"],
                                        style: TextStyle(fontSize: 25)
                                    ),
                                    subtitle: Text(
                                      snapshot.data.documents[index].data["prioridade"],
                                    ),
                                  ),
                                  ButtonTheme.bar(
                                    child: ButtonBar(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.info),
                                          onPressed: () => showInfo(context, index, snapshot),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                        });
                }
              }),
        ),
      ],
    );
  }
}