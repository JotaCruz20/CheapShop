import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/models/produto.dart';
import 'package:app/screens/lista/list_tile.dart';
import 'dart:collection';


class ProdList extends StatefulWidget {
  List<ProdTile> prodsF = new List();

  List<ProdTile> getProdsChecked() {
    List<ProdTile> listChecked = new List();
    if (prodsF != null) {
      for (var i = 0; i < prodsF.length; i++) {
        if (prodsF[i].getCheck() == true) {
          listChecked.add(prodsF[i]);
        }
      }
      return listChecked;
    }
  }

  @override
  _ProdListSate createState() => _ProdListSate();
}

class _ProdListSate extends State<ProdList> {

  @override
  Widget build(BuildContext context) {
    final prods = Provider.of<List<Produto>>(context) ?? [];
    HashMap doneHash = new HashMap();

    return ListView.builder(
        itemCount: prods.length,
        itemBuilder: (context, index) {
          String add = "${prods[index].tipo} ${prods[index].subtipo}";
          if (doneHash.containsKey(add)) {
            doneHash[add].atulizarProd(prods[index].loja,prods[index].preco);
            return Container();
          }
          else {
            dynamic tile = ProdTile(prod: prods[index],inFinalList: false);
            doneHash.addAll({add:tile});
            widget.prodsF.add(tile);
            return tile;
          }
        }
    );
  }
}
