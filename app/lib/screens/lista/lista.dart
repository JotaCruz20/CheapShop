import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/models/produto.dart';
import 'package:app/screens/lista/list_tile.dart';
import 'dart:collection';


class ProdList extends StatefulWidget {
  List<ProdTile> prodsF = new List();
  String search;
  List<ProdTile> checked;
  
  @override
  ProdList(String search, List<ProdTile> checked){
    this.search=search;
    this.checked=checked;
  }

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
  List<ProdTile> saveProdsChecked() {
    List<ProdTile> listChecked = new List();
    if (prodsF != null) {
      for (var i = 0; i < prodsF.length; i++) {
        if (prodsF[i].getCheck() == true) {
          prodsF[i].prod.selecionado=true;
        }
        listChecked.add(prodsF[i]);
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
          bool flag;
          if (widget.search == "" && widget.checked == []) {
            String add = "${prods[index].tipo} ${prods[index].subtipo}";
            if (doneHash.containsKey(add)) {
              doneHash[add].atulizarProd(prods[index].loja, prods[index].preco);
              return Container();
            }
            else {
              dynamic tile = ProdTile(prod: prods[index]);
              doneHash.addAll({add: tile});
              widget.prodsF.add(tile);
              return tile;
            }
          }
          else if (widget.search == "" && widget.checked != []) {
            String add = "${prods[index].tipo} ${prods[index].subtipo}";
            if (doneHash.containsKey(add)) {
              doneHash[add].atulizarProd(prods[index].loja, prods[index].preco);
              return Container();
            }
            else {
              flag = false;
              widget.checked.forEach((element) {
                if(element.prod.tipo==prods[index].tipo && element.prod.subtipo==prods[index].subtipo){
                    flag = true;
                }
              });
              dynamic tile = ProdTile(prod: prods[index]);
              tile.setCheck(flag);
              flag=false;
              doneHash.addAll({add: tile});
              widget.prodsF.add(tile);
              return tile;
            }
          }
          else if (widget.search != "" && widget.checked == []) {
            String add = "${prods[index].tipo} ${prods[index].subtipo}";
            if (doneHash.containsKey(add)) {
              doneHash[add].atulizarProd(prods[index].loja, prods[index].preco);
              return Container();
            }
            else {
              if(prods[index].tipo.toLowerCase().contains(widget.search.toLowerCase()) || prods[index].subtipo.toLowerCase().contains(widget.search.toLowerCase())) {
                dynamic tile = ProdTile(prod: prods[index]);
                doneHash.addAll({add: tile});
                widget.prodsF.add(tile);
                return tile;
              }
              else
                return Container();
            }
          }
          else{
            String add = "${prods[index].tipo} ${prods[index].subtipo}";
            if (doneHash.containsKey(add)) {
              doneHash[add].atulizarProd(prods[index].loja, prods[index].preco);
              return Container();
            }
            else {
              if(prods[index].tipo.toLowerCase().contains(widget.search.toLowerCase()) || prods[index].subtipo.toLowerCase().contains(widget.search.toLowerCase())) {
                flag = false;
                widget.checked.forEach((element) {
                  if(element.prod.tipo==prods[index].tipo && element.prod.subtipo==prods[index].subtipo){
                      flag = true;
                  }
                });
                dynamic tile = ProdTile(prod: prods[index]);
                tile.setCheck(flag);
                flag=false;
                doneHash.addAll({add: tile});
                widget.prodsF.add(tile);
                return tile;
              }
              else
                return Container();
            }
          }
        }
    );
  }
}
