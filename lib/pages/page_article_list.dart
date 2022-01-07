import 'package:courses/models/magasin.dart';
import 'package:courses/pages/page_article_add.dart';
import 'package:flutter/material.dart';

class PageArticleList extends StatefulWidget {
  final Magasin magasin;
  PageArticleList({Key? key, required this.magasin}) : super(key: key);

  @override
  _PageArticleListState createState() => _PageArticleListState();
}

class _PageArticleListState extends State<PageArticleList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.magasin.nom),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return PageArticleAdd(magasin: widget.magasin);
                }));
              },
              child: Text("Ajouter", style: TextStyle(color: Colors.white),)
          )
        ],
      ),
      body: Text("taudau"),
    );
  }
}
