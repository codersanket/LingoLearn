import 'dart:convert';
import 'package:flutter_apppl/helper/urls.dart';
import 'package:flutter_apppl/data/models/SpeechData.dart';
import 'package:http/http.dart';

class GetDataRepo {
  //fetching stocks value from api
  Future<SpeechData>  getData(String word) async {
    final url = Urls.mainUrl+word;
    final Uri _uri = Uri.parse(url);
    //var response = await get(_uri);
    var authorization = 'Token bdc1ab0e0494b4c6423589ff14f30efb788a50ba';
    final response = await get(
        _uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': authorization,
        }
    );
    var data = json.decode(response.body);
    print(data);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      SpeechData  stocks = SpeechData.fromJson(data);
      return stocks;
    } else {
      throw Exception('Failed');
    }
  }

}
