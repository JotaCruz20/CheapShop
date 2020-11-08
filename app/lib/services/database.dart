import 'package:app/models/produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{
  final String uid;

  DatabaseService({this.uid});
  //collection reference

  final CollectionReference  prodCollection = Firestore.instance.collection('teste');

  //brew list from snapshot
  List<Produto> _prodListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Produto(
          tipo: doc.data['tipo'] ?? ' ',
          subtipo: doc.data['subtipo'] ?? ' ',
          preco:  doc.data['preco'].toDouble() ?? ' ',
          loja: doc.data['loja']
      );
    }).toList();
  }

  //get brew stream
  Stream<List<Produto>> get prods{
    return prodCollection.snapshots().map(_prodListFromSnapshot);
  }


}