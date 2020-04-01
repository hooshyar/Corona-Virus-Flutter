import 'package:corona_virus_map/src/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:mccounting_text/mccounting_text.dart';

class CountriesCard extends StatelessWidget {
  final int coronaCases;
  final int deaths;
  final int recovered;
  final String countryName1;
  final String countryName2;
  final int todayCases;
  final int todayDeaths;
  final int critical;
  final Color color;
  final String flag;

  const CountriesCard(
      {Key key,
      this.coronaCases,
      this.deaths,
      this.recovered,
      this.color,
      this.countryName1,
      this.countryName2,
      this.todayCases,
      this.todayDeaths,
      this.critical,
      this.flag})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: <Widget>[
            Container(
              width: 130,
              height: 320,
              color: Colors.black87,
            ),
            Container(
              decoration: BoxDecoration(
                  color: color ?? Colors.black87,
                  gradient: _whichGColor(cases: coronaCases, deaths: deaths)),
              width: 130,
              height: 270,
              child: Column(
                children: <Widget>[
                  Divider(
                    height: 5,
                    color: Colors.transparent,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: FittedBox(
                      child: Text(
                        countryName1 != null
                            ? '$countryName1'
                            : '$countryName2',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      height: 10,
                      color: Colors.white60,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: McCountingText(
                      begin: 0,
                      end: coronaCases.toDouble(),
//            precision: 1,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
//          Text('$coronaCases'),
                  Text(
                    'Cases',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Divider(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: McCountingText(
                      begin: 0,
                      end: deaths.toDouble(),
//            precision: 1,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
                  Text(
                    'Deaths',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Divider(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: McCountingText(
                      begin: 0,
                      end: recovered.toDouble(),
//            precision: 1,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
                  Text(
                    'Recovered',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Divider(
                      height: 5,
                      color: Colors.white60,
                    ),
                  ),
                  McCountingText(
                    begin: 0,
                    end: todayCases.toDouble(),
//            precision: 1,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOutCubic,
                  ),
                  Text(
                    'Today Cases',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: McCountingText(
                      begin: 0,
                      end: todayDeaths.toDouble(),
//            precision: 1,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
                  Text(
                    'Today Deaths',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient _whichGColor({int cases, int deaths}) {
    if (cases < 1) {
      return greenGColor;
    } else if (deaths < 1) {
      return amberGColor;
    } else {
      return redGColor;
    }
  }
}
