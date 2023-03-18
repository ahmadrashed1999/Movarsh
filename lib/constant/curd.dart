import 'dart:io';

import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:movarsh/constant/linkes.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:path/path.dart';

class Curd {
  getHttp(url) async {
    try {
      var response = await Dio().get(api_linkes + url, queryParameters: {
        'api_key': api_key, 'page': 1,
        // "media_type": "movie",
        // "time_window": "week"
      });
      return (response);
    } catch (e) {
      return (e);
    }
  }

  getHttpl(url) async {
    try {
      var response = await Dio().get(api_linkes + url, queryParameters: {
        'api_key': api_key, 'page': 1,
        // "media_type": "movie",
        // "time_window": "week"
      });
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.data);

        return jsonResponse;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      return (e);
    }
  }


  postrequest(String url, Map data) async {
    try {
      var response = await http.post(
        Uri.parse(
          url,
        ),
        body: data,
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        return jsonResponse;
      } else {
        print("${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  ///Upload Files
//   postRequestWithFile(String url, Map data, File file) async {
//     var request = http.MultipartRequest("POST", Uri.parse(url));
//     var length = await file.length();
//     var stream = http.ByteStream(file.openRead());
//     var multiFile = http.MultipartFile(
//       'file',
//       stream,
//       length,
//       filename: basename(file.path),
//     );
//     request.headers.addAll("");
//     //upload the file on request which go to server
//     //تحميل الملف علر الريكوست الى السيرفر
//     request.files.add(multiFile);
//     data.forEach((key, value) {
//       request.fields[key] = value;
//     });
//     var myRequest = await request.send();
//     var response = await http.Response.fromStream(myRequest);
//     if (myRequest.statusCode == 200) {
//       var jsonResponse = jsonDecode(response.body);
//       return jsonResponse;
//     } else {
//       print("${myRequest.statusCode}");
//     }
//   }
// }
}
