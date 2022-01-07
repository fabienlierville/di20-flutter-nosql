import 'package:courses/global_vars.dart';
import 'package:courses/models/magasin.dart';
import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des magasins"),
        actions: [
          TextButton(
              onPressed: (){
                upsert(null);
              },
              child: Text("Ajouter", style: TextStyle(color: Colors.white),)
          )
        ],
      ),
      body: Center(),
    );
  }

  Future<void> upsert(Magasin? magasin) async{
    String? newMagasinNom;
    String? newMagasinVille;

    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Ajouter/Modifier Magasin"),
            content: Container(
              height: MediaQuery.of(context).size.height / 5,
              child: Column(
                children: [
                  TextField(
                    controller: TextEditingController(text: magasin?.nom),
                    onChanged: (String value){
                      newMagasinNom = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Nom du Magasin"
                    ),
                  ),
                  TextField(
                    controller: TextEditingController(text: magasin?.ville),
                    onChanged: (String value){
                      newMagasinVille = value;
                    },
                    decoration: InputDecoration(
                        labelText: "Ville du Magasin"
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    if(newMagasinVille != null && newMagasinNom !=null && GlobalVars.store !=null){
                      Magasin magasin = Magasin(nom: newMagasinNom!, ville: newMagasinVille!);


                    }
                  },
                  child: Text("Valider")
              )
            ],
          );
        }
    );
  }
}
