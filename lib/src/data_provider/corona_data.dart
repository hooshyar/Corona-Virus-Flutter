import 'dart:convert';

import 'package:corona_virus_map/src/models/corona_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CoronaProvider with ChangeNotifier {
  final List<CoronaCountry> coronaCountries = [];
  CoronaWorld coronaWorld;
  bool loading = false;

  Future<List<CoronaCountry>> getCoronaData() async {
    clearCountries();
    await getCoronaWorld();
    await _get('https://corona.lmao.ninja/countries')
        .catchError((e) => e.toString())
        .then((value) {
      var jsonObj;
      jsonObj = value;
      for (int i = 0; i < jsonObj.length; i++) {
        coronaCountries.add(
          CoronaCountry.fromMap(jsonObj[i]),
        );
      }
      return coronaCountries;
    });
    debugPrint(coronaCountries.length.toString());
    notifyListeners();
    return coronaCountries;
  }

  Future<CoronaWorld> getCoronaWorld() async {
    await _get('https://corona.lmao.ninja/all')
        .catchError((e) => e.toString())
        .then((value) {
      var jsonObj;
      jsonObj = value;

      coronaWorld = CoronaWorld.fromMap(jsonObj);

      return coronaWorld;
    });
    notifyListeners();
    return coronaWorld;
  }

  Future _get(String url) async {
    dynamic jsonObj;
    String endpoint = url;
    try {
      Response response =
          await http.get(endpoint, headers: {"Accept": "application/json"});

      // Error handling
      if (response.statusCode != 200) {
        print("status code != 200");
        return null;
      }
      jsonObj = json.decode(response.body);
    } catch (e) {
      debugPrint('error = ' + e);
    }

    if (jsonObj is List) {
      return jsonObj.map((item) => item as Map).toList();
    }

    return jsonObj;
  }

  void makeLoadingFalse() {
    loading = false;
//    notifyListeners();
  }

  void makeLoadingTrue() {
    loading = true;
//    notifyListeners();
  }

  void clearCountries() {
    coronaCountries.clear();
  }
}
