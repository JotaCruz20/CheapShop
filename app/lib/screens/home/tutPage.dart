import 'package:animated_walkthrough/animated_walkthrough.dart';
import 'package:app/screens/home/home.dart';
import 'package:app/screens/lista/listaFinal.dart';
import 'package:flutter/material.dart';
import 'LocalStorage.dart';

class OnBoardingPage  extends StatelessWidget {

  void _onIntroEnd(context) {
    Navigator.pop(context);
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/tut/$assetName.jpeg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override

  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.fromLTRB(16.0, 35.0, 16.0, 16.0),
        imageBackgroudColor: Colors.blueAccent,
        imageFlex: 2,
    );
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Ecrã Atual",
          body:
          "Este ecrã mostra as listas que tem gravadas.\nPara adicionar clique aqui:\n",
          image: _buildImage('first'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Lista Atual",
          body:
          "Aqui vai ter todos os produtos que adicionou a lista.\nPara dicionar clique no 2º botão, assim que tiver todos os produtos que quer, clique no 1º.",
          image: _buildImage('lista'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Lista Produtos",
          body:
          "Neste ecrã estarão todos os produtos disponiveis, poderá selecionar os que quiser, e clicar no botão quando acabar.",
          image: _buildImage('prods'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Lista Produtos",
          body:
          "Após adicionar produtos pode adicionar a sua quantidade. Se quiser pode voltar a adicionar mais produtos, ou quando tiver satisfeito clicar no botão de concluir.",
          image: _buildImage('qntidade'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Lista Final",
          body:
          "No final vai ser deparado com a lista final, onde vai poder ter informação sobre a loja mais barata, assim como o preço total e todos os produtos selecionados, onde poderá marcar os que já comprou ou não",
          image: _buildImage('final_list'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Fim",
          body:
          "Após dar nome á lista poderá voltar para trás, onde a lista aparecerá para a poder editar ou eliminar",
          image: _buildImage('final_list'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Final'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Fechar', style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
