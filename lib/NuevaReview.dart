import 'package:AppFlutter/api.dart';
import 'package:flutter/material.dart';

class NuevaReview extends StatefulWidget {
  final String idRestaurante;

  NuevaReview({@required this.idRestaurante});

  @override
  _NuevaReviewState createState() => _NuevaReviewState();
}

class _NuevaReviewState extends State<NuevaReview> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerComentario = TextEditingController();
  int rating = 1;

  enviar() async {
    Map<String, dynamic> json = {
      "restaurant": widget.idRestaurante,
      "email": controllerEmail.text,
      "comments": controllerComentario.text,
      "rating": rating,
    };
    print(json);

    FocusScope.of(context).unfocus();

    bool regreso = await ApiHandler().nuevaReview(json);

    if (regreso) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text('Nueva reseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Center(child: Text("Calificación")),
            Center(
              child: DropdownButton(
                  value: rating,
                  items: [
                    DropdownMenuItem(child: Text("1"), value: 1),
                    DropdownMenuItem(child: Text("2"), value: 2),
                    DropdownMenuItem(child: Text("3"), value: 3),
                    DropdownMenuItem(child: Text("4"), value: 4),
                    DropdownMenuItem(child: Text("5"), value: 5)
                  ],
                  onChanged: (nuevoRating) {
                    setState(() {
                      rating = nuevoRating;
                    });
                  }),
            ),
            TextFormField(
              controller: controllerEmail,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: "Email",
              ),
            ),
            TextFormField(
              controller: controllerComentario,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.note_add),
                labelText: "Comentario",
              ),
            ),
            RaisedButton(
              child: Text("Enviar"),
              onPressed: enviar,
            )
          ],
        ),
      ),
    );
  }
}
