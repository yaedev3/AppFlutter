import 'package:AppFlutter/TarjetaResturante.dart';
import 'package:flutter/material.dart';
import 'package:AppFlutter/api.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  List restaurantes = [];
  bool cargar = false;

  obtenerRestaurantes() async {
    setState(() {
      cargar = true;
    });

    restaurantes = await ApiHandler().obtenerRestaurantes();
    // await ApiHandler().obtenerRestaurantes();

    setState(() {
      cargar = false;
    });
  }

  @override
  void initState() {
    super.initState();

    obtenerRestaurantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text("Retaurantes"),
      ),
      body: !cargar
          ? ListView.builder(
              itemBuilder: (context, i) => TarjetaRestaurante(
                restaurante: restaurantes[i],
              ),
              itemCount: restaurantes.length,
            )
          : Center(),
    );
  }
}
