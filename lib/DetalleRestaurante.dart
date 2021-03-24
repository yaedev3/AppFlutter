import 'package:AppFlutter/NuevaReview.dart';
import 'package:AppFlutter/PantallaCarga.dart';
import 'package:AppFlutter/TarjetaReview.dart';
import 'package:AppFlutter/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetalleRestaurante extends StatefulWidget {
  final restaurante;

  DetalleRestaurante({@required this.restaurante});

  @override
  _DetalleRestauranteState createState() => _DetalleRestauranteState();
}

class _DetalleRestauranteState extends State<DetalleRestaurante> {
  RefreshController refreshController = RefreshController(initialRefresh: true);
  List reviews = [];
  bool cargar = false;

  cambiaRuta() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NuevaReview(
          idRestaurante: widget.restaurante['slug'],
        ),
      ),
    ).then((value) => refreshController.requestRefresh());
  }

  obtenerReviews() async {
    setState(() {
      cargar = true;
    });
    reviews = await ApiHandler().obtenerReviews(widget.restaurante['slug']);

    if (this.mounted) {
      setState(() {
        cargar = false;
      });
    }
  }

  void onRefresh() async {
    obtenerReviews();
    if (this.mounted) {
      setState(() {
        refreshController.refreshCompleted();
      });
    }
  }

  void onLoading() async {
    obtenerReviews();
    if (this.mounted) {
      setState(() {
        refreshController.refreshCompleted();
      });
    }
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
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropMaterialHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(
                child: body,
              ),
            );
          },
        ),
        controller: refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: Padding(
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
              SizedBox(height: 10),
              Text("Reseñas:"),
              SizedBox(height: 30),
              !cargar
                  ? Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, i) => TarjetaReview(
                          review: reviews[i],
                        ),
                        itemCount: reviews.length,
                      ),
                    )
                  : pantallaCarga(),
            ],
          ),
        ),
      ),
    );
  }
}
