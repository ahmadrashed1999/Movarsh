import 'package:flutter/material.dart';
import 'package:movarsh/constant/theme.dart';

import '../../../constant/curd.dart';

class Category extends StatefulWidget {
  Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var lists = [];
  @override
  Widget build(BuildContext context) {
    return lists.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: double.infinity,
            child: ListView.builder(
              itemCount: lists.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: secondaryColor,
                  child: ListTile(
                    title: Center(
                      child: Text(
                        '${lists[index]['name']}',
                        style: subHeadingStyle2.copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    listofmovies();
  }

  listofmovies() async {
    var res = await Curd().getHttp('genre/movie/list');
    if (res.statusCode == 200) {
      // If the server did return a 200 OK response,a
      // then parse the JSON.
      // print(res.data['results'][1]);
      lists.add(res.data['genres']);
      lists = lists[0];

      setState(() {});
      print(lists);
      // print(tfilms);

      return res;
    } else {}
  }
}
