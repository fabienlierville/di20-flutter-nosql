
import 'dart:async';

import 'package:courses/global_vars.dart';
import 'package:courses/models/article.dart';
import 'package:courses/models/magasin.dart';
import 'package:courses/objectbox.g.dart';

class ArticleManager{

  static Stream<List<Article>> getAllStream(Magasin mag){
    StreamController<List<Article>> controller = StreamController<List<Article>>();
    if(GlobalVars.store != null){
      Stream<List<Article>> articles = GlobalVars.store!.box<Article>().query(Article_.magasin.equals(mag.id)).watch(triggerImmediately: true).map((event) => event.find());
      controller.addStream(articles);
    }
    return controller.stream;
  }

  static int upsert(Article art, Magasin mag){
    if(GlobalVars.store != null){
      art.magasin.target = mag;
      return GlobalVars.store!.box<Article>().put(art);
    }
    return 0;
  }

}