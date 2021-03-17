import 'package:flutter/material.dart';

class TarjetaReview extends StatefulWidget {
  final review;

  TarjetaReview({@required this.review});

  @override
  _TarjetaReviewState createState() => _TarjetaReviewState();
}

class _TarjetaReviewState extends State<TarjetaReview> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(widget.review['rating'].toString()),
                  Icon(Icons.star),
                ],
              ),
              subtitle: Text(widget.review['comments']),
              // subtitle: Text(widget.review['description']),
            ),
          ],
        ),
      ),
    );
  }
}
