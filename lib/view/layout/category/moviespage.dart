import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movarsh/view/layout/pages/movieimfo.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../constant/curd.dart';
import '../../../constant/methods/methoods.dart';
import '../../../constant/theme.dart';
import '../../../model/moviemodel.dart';

class MoviesPage extends StatefulWidget {
  MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {


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
                      child: futuerBuilder(getMovies('discover/movie')),
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
                        child: futuerBuilder(getMovies('movie/top_rated/'))),
                    Row(
                      children: [
                        Text('Upcoming', style: subHeadingStyle),
                        Spacer(),
                        Text('See All', style: subHeadingStyle2),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 250,
                      child: futuerBuilder(getMovies('movie/upcoming')),
                    )
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
          var id = await Curd().getHttp('movie/${list[index]['id']}/videos');
          var seem =
              await Curd().getHttp('movie/${list[index]['id']}/similar');
          var idimg = await Curd().getHttp('movie/${list[index]['id']}/images');
          var res = await Curd().getHttp('movie/${list[index]['id']},');
          print('================');
          print(seem.data['results']);
          print('================');
          if (res.statusCode == 200) {
            MovieModel model = await MovieModel.fromJson(res.data);
            // print(res.data);
            Get.to(
              () => MovieInfo(
                movieModel: model,
                similarMovies: seem.data['results'],
                links: id.data['results'] == null
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
                      list[index]['backdrop_path'].toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              list[index]['title'].toString(),
              style: subHeadingStyle2.copyWith(),
            ),
            Row(
              children: [
                ratingBar(list, index),
              ],
            )
          ],
        ),
      ),
    );
  }
}
