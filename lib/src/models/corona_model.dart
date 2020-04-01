import 'dart:convert';

CoronaCountry coronaCountriesFromJson(String str) =>
    CoronaCountry.fromMap(json.decode(str));

String coronaCountriesToJson(CoronaCountry data) => json.encode(data.toMap());

class CoronaCountry {
  String country;
  CountryInfo countryInfo;
  num cases;
  num todayCases;
  num deaths;
  num todayDeaths;
  num recovered;
  num active;
  num critical;
  num casesPerOneMillion;
  num deathsPerOneMillion;
  num updated;

  CoronaCountry({
    this.country,
    this.countryInfo,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.updated,
  });

  factory CoronaCountry.fromMap(Map<String, dynamic> json) => CoronaCountry(
        country: json["country"] == null ? null : json["country"],
        countryInfo: json["countryInfo"] == null
            ? null
            : CountryInfo.fromMap(json["countryInfo"]),
        cases: json["cases"] == null ? null : json["cases"],
        todayCases: json["todayCases"] == null ? null : json["todayCases"],
        deaths: json["deaths"] == null ? null : json["deaths"],
        todayDeaths: json["todayDeaths"] == null ? null : json["todayDeaths"],
        recovered: json["recovered"] == null ? null : json["recovered"],
        active: json["active"] == null ? null : json["active"],
        critical: json["critical"] == null ? null : json["critical"],
        casesPerOneMillion: json["casesPerOneMillion"] == null
            ? null
            : json["casesPerOneMillion"],
        deathsPerOneMillion: json["deathsPerOneMillion"] == null
            ? null
            : json["deathsPerOneMillion"],
        updated: json["updated"] == null ? null : json["updated"],
      );

  Map<String, dynamic> toMap() => {
        "country": country == null ? null : country,
        "countryInfo": countryInfo == null ? null : countryInfo.toMap(),
        "cases": cases == null ? null : cases,
        "todayCases": todayCases == null ? null : todayCases,
        "deaths": deaths == null ? null : deaths,
        "todayDeaths": todayDeaths == null ? null : todayDeaths,
        "recovered": recovered == null ? null : recovered,
        "active": active == null ? null : active,
        "critical": critical == null ? null : critical,
        "casesPerOneMillion":
            casesPerOneMillion == null ? null : casesPerOneMillion,
        "deathsPerOneMillion":
            deathsPerOneMillion == null ? null : deathsPerOneMillion,
        "updated": updated == null ? null : updated,
      };
}

class CountryInfo {
  num id;
  String iso2;
  String iso3;
  num lat;
  num long;
  String flag;

  CountryInfo({
    this.id,
    this.iso2,
    this.iso3,
    this.lat,
    this.long,
    this.flag,
  });

  factory CountryInfo.fromMap(Map<String, dynamic> json) => CountryInfo(
        id: json["_id"] == null ? null : json["_id"],
        iso2: json["iso2"] == null ? null : json["iso2"],
        iso3: json["iso3"] == null ? null : json["iso3"],
        lat: json["lat"] == null ? null : json["lat"],
        long: json["long"] == null ? null : json["long"],
        flag: json["flag"] == null ? null : json["flag"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "iso2": iso2 == null ? null : iso2,
        "iso3": iso3 == null ? null : iso3,
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
        "flag": flag == null ? null : flag,
      };
}

class CoronaWorld {
  int cases;
  int deaths;
  int recovered;
  int updated;
  int active;
  int affectedCountries;

  CoronaWorld({
    this.cases,
    this.deaths,
    this.recovered,
    this.updated,
    this.active,
    this.affectedCountries,
  });

  factory CoronaWorld.fromMap(Map<String, dynamic> json) => CoronaWorld(
        cases: json["cases"] == null ? null : json["cases"],
        deaths: json["deaths"] == null ? null : json["deaths"],
        recovered: json["recovered"] == null ? null : json["recovered"],
        updated: json["updated"] == null ? null : json["updated"],
        active: json["active"] == null ? null : json["active"],
        affectedCountries: json["affectedCountries"] == null
            ? null
            : json["affectedCountries"],
      );

  Map<String, dynamic> toMap() => {
        "cases": cases == null ? null : cases,
        "deaths": deaths == null ? null : deaths,
        "recovered": recovered == null ? null : recovered,
        "updated": updated == null ? null : updated,
        "active": active == null ? null : active,
        "affectedCountries":
            affectedCountries == null ? null : affectedCountries,
      };
}
