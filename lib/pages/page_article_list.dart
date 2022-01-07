import 'dart:io';

import 'package:courses/models/article.dart';
import 'package:courses/models/article_manager.dart';
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
      body: StreamBuilder<List<Article>>(
        stream: ArticleManager.getAllStream(widget.magasin),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(child: Text("No Data"),);
          }else{
            List<Article>? articles = snapshot.data;
            if(articles == null || articles.length == 0){
              return Center(child: Text("No Articles"),);
            }

            return GridView.builder(
              itemCount: articles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index){
                  Article art = articles[index];
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Nom
                        Text(art.nom),
                        //Image
                        Expanded(
                            child: (art.image == null)
                                ?Image.asset("assets/img/no_image.png")
                                :Image.file(File(art.image!))
                        ),
                        // Prix + Delete
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${art.prix}€"),
                            IconButton(
                              onPressed: (){
                                ArticleManager.remove(art);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }

            );
          }
        },
      ),
    );
  }
}
