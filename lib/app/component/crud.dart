import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

mixin class Crud {
  getReques(String url) async {
    try {
      var respons = await http.get(Uri.parse(url));
      if (respons.statusCode == 200) {
        var responsbody = jsonDecode(respons.body);

        return responsbody;
      } else {
        print('error${respons.statusCode}');
      }
    } catch (e) {
      print('error catch $e');
    }
  }

  postReques(String url, Map data) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      var respons = await http.post(Uri.parse(url), body: data);
      if (respons.statusCode == 200) {
        var responsbody = jsonDecode(respons.body);

        return responsbody;
      } else {
        print('error${respons.statusCode}');
      }
    } catch (e) {
      print('error catch $e');
    }
  }

  postRequestWithFile(String url, File file, Map data) async {
    //name the type of request and the path
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multiPartFile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.files.add(multiPartFile);
    //to send the data with the file
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    //to send the request
    var myRequest = await request.send();
    // to get the respons
    var respons = await http.Response.fromStream(myRequest);
    if (myRequest.statusCode == 200) {
      return jsonDecode(respons.body);
    } else {
      print('Error ${myRequest.statusCode}');
    }
  }
}
