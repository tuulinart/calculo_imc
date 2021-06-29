import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controllerPeso = TextEditingController();
  TextEditingController controllerAltura = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados!";

  void _calculate() {
    setState(() {
      double peso = double.parse(controllerPeso.text);
      double altura = double.parse(controllerAltura.text);
      double imc = peso / (altura * altura);
      if (imc <= 18.5) {
        _infoText =
            ("Você está abaixo do peso!!  ( ${imc.toStringAsPrecision(3)} ) ");
      } else if (imc > 18.5 && imc <= 24.9) {
        _infoText = ("Você está normal!! ( ${imc.toStringAsPrecision(3)} ) ");
      } else if (imc > 24.9 && imc <= 30.0) {
        _infoText =
            ("Você está sobrepeso!! ( ${imc.toStringAsPrecision(3)} ) ");
      } else
        _infoText = ("Você está Obeso!! ( ${imc.toStringAsPrecision(3)} ) ");
    });
  }

  void _resetField() {
    controllerPeso.text = "";
    controllerAltura.text = "";
    setState(() {
      _infoText = "Informe seus novos dados!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetField,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            //Comando para que o teclado possa ser aberto por cima de dados e,
            //e assim rolar a tela pra baixo com o teclado aberto.
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Form(
              key: _globalKey,
              child: Column(
                //Para adicionar um corpo, que vai ser uma Coluna.
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //Para alinhar os itens no meio.
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 110.0,
                    color: Colors.red,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso em (KG)",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontStyle: FontStyle.italic),
                    controller: controllerPeso,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu Peso!!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura em (CM)",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontStyle: FontStyle.italic),
                    controller: controllerAltura,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua altura!!";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton
                          //Botão com fundo.
                          (
                        onPressed: () {
                          if (_globalKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular   :)",
                          style: TextStyle(color: Colors.black, fontSize: 23.0),
                        ),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 23.0),
                  )
                ],
              ),
            )));
  }
}
