import 'package:AppFlutter/DetalleRestaurante.dart';
import 'package:flutter/material.dart';

class TarjetaRestaurante extends StatefulWidget {
  final restaurante;

  TarjetaRestaurante({@required this.restaurante});

  @override
  _TarjetaRestauranteState createState() => _TarjetaRestauranteState();
}

class _TarjetaRestauranteState extends State<TarjetaRestaurante> {
  cambiaRuta() async {
    print("Se cambio");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetalleRestaurante(
                restaurante: widget.restaurante,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Image.network(widget.restaurante['logo']),
                title: Text(widget.restaurante['name']),
                // subtitle: Text(widget.restaurante['description']),
              ),
            ],
          ),
        ),
        onTap: cambiaRuta,
      ),
    );
  }
}
