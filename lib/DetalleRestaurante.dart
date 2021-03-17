import 'package:AppFlutter/TarjetaReview.dart';
import 'package:flutter/material.dart';

class DetalleRestaurante extends StatelessWidget {
  final restaurante;

  DetalleRestaurante({@required this.restaurante});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(restaurante['name']),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
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
                child: Image.network(restaurante['logo'])),
            ),
            Text(restaurante["description"]),
            // Text(restaurante["rating"]),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, i) => TarjetaReview(
                  review: restaurante["reviews"][i],
                ),
                itemCount: restaurante["reviews"].length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
