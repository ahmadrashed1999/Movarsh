import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movarsh/constant/curd.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

ratingBar(list, index) {
  return RatingBar.builder(
    tapOnlyMode: true,
    initialRating: list[index]['vote_average'] / 2,
    itemSize: 12,
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: Colors.amber,
    ),
    onRatingUpdate: (rating) {
      print(rating);
    },
  );
}

shimmer() {
  return Shimmer(
    duration: Duration(seconds: 3),
    // This is NOT the default value. Default value: Duration(seconds: 0)
    interval: Duration(seconds: 5),
    // This is the default value
    color: Colors.white,
    // This is the default value
    colorOpacity: 0.3,
    // This is the default value
    enabled: true,
    // This is the default value
    direction: ShimmerDirection.fromLTRB(),
    child: Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300],
      ),
    ),
  );
}

_buildItem(BuildContext context, String title, Widget widget) {
  return InkWell(
    onTap: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => widget));
    },
    child: Container(
      padding: EdgeInsets.all(10),
      child: Text(title),
    ),
  );
}

getMovies(linkView) async {
  var response = await Curd().getHttp(linkView);
  return response.data['results'];
}
