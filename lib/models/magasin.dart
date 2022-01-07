
import 'package:objectbox/objectbox.dart';

@Entity()
class Magasin{
  int id; //Champ spécial qui sera géré par ObjectBox

  String nom;
  String ville;

  Magasin({this.id=0,required this.nom, required this.ville});


}