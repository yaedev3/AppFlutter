import 'package:AppFlutter/NuevaReview.dart';
import 'package:AppFlutter/TarjetaReview.dart';
import 'package:flutter/material.dart';

class DetalleRestaurante extends StatefulWidget {
  final restaurante;

  DetalleRestaurante({@required this.restaurante});

  @override
  _DetalleRestauranteState createState() => _DetalleRestauranteState();
}

class _DetalleRestauranteState extends State<DetalleRestaurante> {
  cambiaRuta() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NuevaReview(
                idRestaurante: widget.restaurante["slug"],
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(widget.restaurante['name']),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cambiaRuta();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Container(
                  height: 100,
                  width: 100,
                  child: Image.network(widget.restaurante['logo'])),
            ),
            Text(widget.restaurante["description"]),
            // Text(restaurante["rating"]),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, i) => TarjetaReview(
                  review: widget.restaurante["reviews"][i],
                ),
                itemCount: widget.restaurante["reviews"].length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
