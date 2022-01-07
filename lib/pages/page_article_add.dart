import 'dart:io';

import 'package:courses/models/article.dart';
import 'package:courses/models/article_manager.dart';
import 'package:courses/models/magasin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageArticleAdd extends StatefulWidget {
  final Magasin magasin;
   PageArticleAdd({Key? key, required this.magasin}) : super(key: key);

  @override
  _PageArticleAddState createState() => _PageArticleAddState();
}

class _PageArticleAddState extends State<PageArticleAdd> {
  String? image;
  String? nom;
  double? prix;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un article"),
        actions: [
          TextButton(
              onPressed: (){
                if(nom != null && prix !=null && widget.magasin != null){
                  Article article = Article(nom: nom!, prix: prix!, image: image);
                  int id = ArticleManager.upsert(article, widget.magasin);
                  if(id != 0){
                    Navigator.pop(context);
                  }
                }
              },
              child: Text("Valider", style: TextStyle(color: Colors.white,)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Article à ajouter", textScaleFactor: 2, style: TextStyle(color: Colors.red),),
            Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (image==null)
                    ?Image.asset("assets/img/no_image.png")
                    :Image.file(File(image!)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: null, icon: Icon(Icons.camera)),
                      IconButton(onPressed: null, icon: Icon(Icons.photo_library)),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Nom"
                    ),
                    onChanged: (String value){
                      nom = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Prix"
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String value){
                      prix = double.tryParse(value) ?? 0;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getImage(ImageSource source) async{
    XFile? pickerFile = await picker.pickImage(source: source);
    if(pickerFile != null){
      setState(() {
        image = pickerFile.path;
      });
    }
  }

}
