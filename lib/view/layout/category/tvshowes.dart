import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:movarsh/model/tvmodel.dart';
import 'package:movarsh/view/layout/pages/movieimfo.dart';
import 'package:movarsh/view/layout/pages/tvinfo.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../constant/curd.dart';
import '../../../constant/methods/methoods.dart';
import '../../../constant/theme.dart';
import '../../../model/moviemodel.dart';

class TvShows extends StatefulWidget {
  TvShows({Key? key}) : super(key: key);

  @override
  State<TvShows> createState() => _TvShowsState();
}

class _TvShowsState extends State<TvShows> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(),
            ),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text('Popular', style: subHeadingStyle),
                        Spacer(),
                        Text('See All', style: subHeadingStyle2),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 250,
                      child: futuerBuilder(getMovies('tv/popular')),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text('Top Rating', style: subHeadingStyle),
                        Spacer(),
                        Text('See All', style: subHeadingStyle2),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 250,
                      child: futuerBuilder(getMovies('tv/top_rated')),
                    ),
                    Row(
                      children: [
                        Text('Airing today', style: subHeadingStyle),
                        Spacer(),
                        Text('See All', style: subHeadingStyle2),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 250,
                      child: futuerBuilder(getMovies('tv/airing_today')),
                    ),
                  ]),
            ),
          ),
        )
      ],
    );
  }

  futuerBuilder(futuer) {
    return FutureBuilder(
      future: futuer,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print('===========');
        print(snapshot.data);
        if (snapshot.hasData) {
          return ListView.separated(
            separatorBuilder: (context, index) => Container(
              width: 20,
            ),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return cardMovie(index, snapshot.data);
            },
          );
        } else {
          return shimmer();
        }
      },
    );
  }

  cardMovie(int index, list) {
    return Container(
      width: 150,
      child: InkWell(
        onTap: () async {
          var id = await Curd().getHttp('/tv/${list[index]['id']}/videos');
          var idimg = await Curd().getHttp('/tv/${list[index]['id']}/images');
          var res = await Curd().getHttp('/tv/${list[index]['id']}');
          var seem = await Curd().getHttp('tv/${list[index]['id']}/similar');
          print(idimg.data.toString());
          print('=========================');
          if (res.statusCode == 200) {
            TvModel model = await TvModel.fromJson(res.data);
            // print(res.data);
            Get.to(
              () => TvInfo(
                similarTv: seem.data['results'],
                tvModel: model,
                links: id.data == null
                    ? [
                        {'key': "ovK4Ik3HIJI"}
                      ]
                    : id.data['results'],
                images: idimg.data['backdrops'],
              ),
            );

            return res;
          } else {}
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(films[index]['original_title']
            //     .toString()),

            Container(
              height: 200,
              width: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage('https://image.tmdb.org/t/p/original' +
                      list[index]['poster_path'].toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              list[index]['name'].toString(),
              style: subHeadingStyle2,
            ),
            Row(
              children: [
                Text('Rating: ', style: subHeadingStyle2),
                ratingBar(list, index),
              ],
            )
          ],
        ),
      ),
    );
  }
}
