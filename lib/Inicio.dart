import 'package:AppFlutter/PantallaCarga.dart';
import 'package:AppFlutter/TarjetaResturante.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AppFlutter/api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  RefreshController refreshController = RefreshController(initialRefresh: true);
  List restaurantes = [];
  bool cargar = false;

  obtenerRestaurantes() async {
    setState(() {
      cargar = true;
    });

    restaurantes = await ApiHandler().obtenerRestaurantes();

    setState(() {
      cargar = false;
    });
  }

  void onRefresh() async {
    obtenerRestaurantes();
    if (this.mounted) {
      setState(() {
        refreshController.refreshCompleted();
      });
    }
  }

  void onLoading() async {
    obtenerRestaurantes();
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
        title: Text("Restaurantes"),
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
        child: !cargar
            ? ListView.builder(
                itemBuilder: (context, i) => TarjetaRestaurante(
                  restaurante: restaurantes[i],
                ),
                itemCount: restaurantes.length,
              )
            : pantallaCarga(),
      ),
    );
  }
}
