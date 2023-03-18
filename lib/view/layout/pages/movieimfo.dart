import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:movarsh/constant/theme.dart';
import 'package:movarsh/controllers/favcontroller.dart';
import 'package:movarsh/model/moviemodel.dart';
import 'package:movarsh/model/similarmodel.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../main.dart';

class MovieInfo extends StatefulWidget {
  final MovieModel movieModel;
  final List similarMovies;
  final List links;
  final List images;
  MovieInfo(
      {Key? key,
      required this.movieModel,
      required this.similarMovies,
      required this.links,
      required this.images
      })
      : super(key: key);

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  late Future<void> _initializeVideoPlayerFuture;

  late YoutubePlayerController _controllery;
  late PlayerState _playerState;
  bool _isPlayerReady = false;
  late bool isVaf;
  late YoutubeMetaData _videoMetaData;
  @override
  void initState() {
    print(widget.links);
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet

    if (widget.links.length > 0) {
      _controllery = YoutubePlayerController(
        initialVideoId: '${widget.links[0]['key']}',
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);

      _playerState = PlayerState.unknown;
      _videoMetaData = const YoutubeMetaData();
    } else {
      _controllery = YoutubePlayerController(
        initialVideoId: 'ovK4Ik3HIJI',
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);

      _playerState = PlayerState.unknown;
      _videoMetaData = const YoutubeMetaData();
    }
    isVaf = favController.getidfav(widget.movieModel.id!);
    super.initState();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controllery.value.isFullScreen) {
      setState(() {
        _playerState = _controllery.value.playerState;
        _videoMetaData = _controllery.metadata;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieModel.title!),
        actions: [
          IconButton(
            icon: !isVaf
                ? Icon(Icons.favorite_border)
                : Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  ),
            onPressed: () {
              print('ssssss');
              if (isVaf) {
                favController.removefav(widget.movieModel.id!);

                setState(() {
                  isVaf = false;
                });
                print(favController.getFav[0].id.toString());
              } else {
                favController.addtoFav(widget.movieModel);
                setState(() {
                  isVaf = true;
                });
                print(favController.getFav[0].id.toString());
              }
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: primaryColor,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            widget.links == null
                ? Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://image.tmdb.org/t/p/original' +
                                widget.images[0]['file_path'].toString(),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: _controllery,
                    ),
                    builder: (context, player) {
                      return Column(
                        children: [
                          // some widgets
                          player,
                          //some other widgets
                        ],
                      );
                    }),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Container(
                      child: Text(widget.movieModel.title!,
                          style: subHeadingStyle)),
                  Spacer(),
                  Column(
                    children: [
                      Text(widget.movieModel.releaseDate!,
                          style: subHeadingStyle2),
                      RatingBar.builder(
                        initialRating: widget.movieModel.voteAverage! / 2,
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
                      ),
                      widget.movieModel.adult == true
                          ? Text('18+', style: subHeadingStyle2)
                          : Text('13+', style: subHeadingStyle2),
                    ],
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child:
                    Text(widget.movieModel.tagline!, style: subHeadingStyle)),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('OverView', style: headingStyle.copyWith(fontSize: 18)),
                  SizedBox(height: 10),
                  Text(widget.movieModel.overview!, style: subHeadingStyle2),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Genres', style: headingStyle.copyWith(fontSize: 18)),
                  SizedBox(height: 10),
                  Container(
                    height: 30,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            widget.movieModel.genres![index].name.toString() +
                                " ",
                            style: subHeadingStyle2,
                            softWrap: true,
                          ),
                        );
                      }),
                      itemCount: widget.movieModel.genres!.length,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Simmilar Movies',
                      style: headingStyle.copyWith(fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 220,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 170,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/original' +
                                          widget.similarMovies[index]
                                                  ['backdrop_path']
                                              .toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: 170,
                              child: Text(
                                widget.similarMovies[index]['title'].toString(),
                                style: subHeadingStyle2.copyWith(),
                                softWrap: true,
                              ),
                            ),
                            RatingBar.builder(
                              tapOnlyMode: true,
                              initialRating: widget.similarMovies[index]
                                      ['vote_average'] /
                                  2,
                              itemSize: 12,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                          ],
                        );
                      }),
                      itemCount: widget.similarMovies.length,
                    ),
                  ),
                  Container(
                    height: 250,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Images',
                            style: headingStyle.copyWith(fontSize: 18)),
                        Container(
                          height: 200,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/original' +
                                      widget.images[index]['file_path']
                                          .toString(),
                                  height: 250,
                                  width: 250,
                                ),
                              );
                            }),
                            itemCount: widget.images.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
