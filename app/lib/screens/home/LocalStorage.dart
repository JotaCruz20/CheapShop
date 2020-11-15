import 'dart:io';
import 'dart:collection';
import 'package:app/models/produto.dart';
import 'package:app/screens/lista/listaFinal.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage{

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> clear() async {
    final file = await _localFile;
    return file.writeAsString('');
  }

  Future<File> writeCounter(List<ListaFinal> listasFinal) async {
    final file = await _localFile;
    String write='';

    // Write the file.
    listasFinal.forEach((element) {
      write+='-';
      write+='${element.loja},${element.preco},${element.nome}';
      element.listaProds.forEach((prod) {
        write+='#';
        write+='${prod.tipo},${prod.subtipo},${prod.preco},${prod.qntidade},${prod.loja}';
        write+='+';
        prod.lojaPreco.forEach((key, value) {
          write+='*';
          write+='$key: $value';
        });
      });
    });
    return file.writeAsString(write);
  }

  Future<List<ListaFinal>> readCounter() async {
    try {
      List<ListaFinal> listasFinal=[];
      final file = await _localFile;
      String nomeLista="",lojaList="",prodTipo="",prodSubTipo="",prodPreco="",prodQntd="",hashNome="",hashVal="",prodLoja="";
      double precoLista;

      // Read the file.
      String data = await file.readAsString();
      List<String> split = data.split("-");

      split.asMap().forEach((index1,element) {
        if(index1!=0) {
          List<String> prods = element.split("#");
          List<String> listSpec = prods[0].split(',');
          List<Produto> prodsLista=[];
          if (listSpec != [] && listSpec[0]!="Lista Inacabada") {
            HashMap lojaPreco = new HashMap();
            nomeLista = listSpec[2];
            precoLista = double.parse(listSpec[1]);
            lojaList = listSpec[0];
            prods.asMap().forEach((index, ele) {
              if (index != 0) {
                List<String> prodSpecs = ele.split('+');
                prodSpecs.asMap().forEach((ind, ele2) {
                  if (ind == 0) {
                    List<String> prodSpecs2 = ele2.split(',');
                    prodTipo = prodSpecs2[0];
                    prodSubTipo = prodSpecs2[1];
                    prodPreco = prodSpecs2[2];
                    prodQntd = prodSpecs2[3];
                    prodLoja = prodSpecs2[4];
                  }
                  else {
                    List<String> hash = ele2.split('*');
                    hash.asMap().forEach((ind, ele3) {
                      if (ind != 0) {
                        List<String> hashDiv = ele3.split(':');
                        hashNome = hashDiv[0];
                        hashVal = hashDiv[1];
                        lojaPreco.addAll({hashNome: hashVal});
                      }
                    });
                    Produto produtoAux = new Produto(tipo: prodTipo, subtipo: prodSubTipo, preco: double.parse(prodPreco), loja: prodLoja);
                    produtoAux.setQntidade(double.parse(prodQntd));
                    produtoAux.setHashMap(lojaPreco);
                    prodsLista.add(produtoAux);
                  }
                });
              }
            });

          }
          ListaFinal listaAux = new ListaFinal(
              listaProds: prodsLista, loja: lojaList, preco: precoLista);
          listaAux.setNome(nomeLista);
          listasFinal.add(listaAux);
        }
      });
      return listasFinal;
    } catch (e) {
      return [];
    }
  }
}