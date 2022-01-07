import 'package:courses/global_vars.dart';
import 'package:courses/models/magasin.dart';
import 'package:courses/objectbox.g.dart';
import 'package:courses/pages/page_article_list.dart';
import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  List<Magasin> magasins = [];

  @override
  void initState() {
    getAllMagasins();
    super.initState();
  }

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
      body: ListView.builder(
        itemCount: magasins.length,
          itemBuilder: (context, index){
            Magasin mag = magasins[index];
            return ListTile(
              title: Text(mag.nom),
              subtitle: Text(mag.ville),
              trailing: IconButton(
                onPressed: (){
                  if(GlobalVars.store != null){
                    GlobalVars.store!.box<Magasin>().remove(mag.id);
                    getAllMagasins();
                  }
                },
                icon: Icon(Icons.delete),
              ),
              leading: IconButton(
                onPressed: (){
                  upsert(mag);
                },
                icon: Icon(Icons.edit),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return PageArticleList(magasin: mag);
                }));
              },
            );
          }
      ),
    );
  }

  ///
  /// Ajouter / Modifier un magasin
  ///
  Future<void> upsert(Magasin? magasin) async{
    String? newMagasinNom = magasin?.nom ?? null;
    String? newMagasinVille = magasin?.ville ?? null;

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
                      if(magasin == null){
                        magasin = Magasin(nom: newMagasinNom!, ville: newMagasinVille!);
                      }else{
                        magasin!.nom = newMagasinNom!;
                        magasin!.ville = newMagasinVille!;
                      }

                      Box box = GlobalVars.store!.box<Magasin>();
                      int id = box.put(magasin);
                      print(id);
                      getAllMagasins();
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Valider")
              )
            ],
          );
        }
    );
  }

  ///
  /// Récupération de tous les magasins
  ///

  void getAllMagasins(){
    List<Magasin> mags = [];
    if(GlobalVars.store != null){
      Box box = GlobalVars.store!.box<Magasin>();

      box.getAll().forEach((mag) {
        mags.add(mag);
      });

      setState(() {
        magasins = mags;
      });
    }
  }



}
