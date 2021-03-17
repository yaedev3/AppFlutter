import 'package:http/http.dart' as http;
import 'dart:convert';

const url = "https://tellurium.behuns.com/api/";
const rutas = {
  "food_types": "https://tellurium.behuns.com/api/food_types/",
  "restaurants": "https://tellurium.behuns.com/api/restaurants/",
  "reviews": "https://tellurium.behuns.com/api/reviews/",
};

class ApiHandler {
  obtenerRutas() async {
    final response = await http.get(url);

    switch (response.statusCode) {
      case 200:
        var body = utf8.decode(response.bodyBytes);
        print(body);
        break;
    }
  }

  obtenerRestaurantes() async {
    final response = await http.get(rutas["restaurants"]);

    switch (response.statusCode) {
      case 200:
        var body = utf8.decode(response.bodyBytes);
        var jBody = jsonDecode(body);
        return jBody;
    }
  }

  nuevaReview(json) async {
    final response = await http.post(rutas["reviews"],
        body: jsonEncode(json),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    print(response.statusCode);

    switch (response.statusCode) {
      case 201:
        return "Se ha enviado con exito el mensaje";
    }
  }
}
