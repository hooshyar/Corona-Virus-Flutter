import 'dart:async';

import 'package:corona_virus_map/src/data_provider/corona_data.dart';
import 'package:corona_virus_map/src/models/corona_model.dart';
import 'package:corona_virus_map/src/screens/Countries_card.dart';
import 'package:corona_virus_map/src/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool _loading = false;
  Completer<GoogleMapController> _controller = Completer();
  String _mapStyle;
  static final CameraPosition _initCamera = CameraPosition(
    target: LatLng(20.4996522, 46.6305755),
    zoom: 3.5,
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

    super.initState();
  }

  Set<Circle> circles = Set();

  _setCircles(List<CoronaCountry> coronaCountries) async {
    circles.clear();
    for (int i = 0; i < coronaCountries.length; i++) {
      circles.add(
        Circle(
          circleId: CircleId(
              coronaCountries[i].country ?? coronaCountries[i].countryInfo.id),
          fillColor: _whichCircleColor(
              cases: coronaCountries[i].cases,
              deaths: coronaCountries[i].deaths),
//          strokeColor: Colors.redAccent.withOpacity(0.5),
          consumeTapEvents: true,
          onTap: () => _scrollController.animateTo(i * 138.toDouble(),
              duration: Duration(seconds: 1), curve: Curves.bounceInOut),
          strokeWidth: 0,
          radius: _whichCircleRadius(
              cases: coronaCountries[i].cases,
              deaths: coronaCountries[i].deaths),
          center: LatLng(
            coronaCountries[i].countryInfo.lat.toDouble(),
            coronaCountries[i].countryInfo.long.toDouble(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CoronaProvider coronaProvider =
        Provider.of<CoronaProvider>(context, listen: false);
    _setCircles(coronaProvider.coronaCountries);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(bottom: 0, left: 5, right: 5),
        child: _loading == true
            ? LinearProgressIndicator()
            : Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: GoogleMap(
                                myLocationButtonEnabled: false,
                                compassEnabled: false,
                                myLocationEnabled: false,
                                mapType: MapType.normal,
                                initialCameraPosition: _initCamera,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                  controller.setMapStyle(_mapStyle);
                                },
                                circles: circles,
                              ),
                            ),
                          ),
                          Container(
                            height: 250,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 0),
                        color: Colors.transparent,
                        width: double.infinity,
                        height: 350,
                        child: coronaProvider.loading == true
                            ? Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: LinearProgressIndicator(),
                              )
                            : Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(4.0),
                                    margin: EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black87),
                                        child: Container(
                                          height: 60,
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () => _goToLocation(
                                                    CameraPosition(
                                                        zoom: 2.30,
                                                        bearing: 5,
                                                        tilt: 3.0,
                                                        target:
                                                            _initCamera.target),
                                                  ),
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              Container(
                                                                child: Text(
                                                                  'Cases',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                child:
                                                                    McCountingText(
                                                                  begin: 0,
                                                                  end: coronaProvider
                                                                      .coronaWorld
                                                                      .cases
                                                                      .toDouble(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        VerticalDivider(
                                                          width: 2,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              Container(
                                                                child: Text(
                                                                  'Deaths',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .redAccent,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                child:
                                                                    McCountingText(
                                                                  begin: 0,
                                                                  end: coronaProvider
                                                                      .coronaWorld
                                                                      .deaths
                                                                      .toDouble(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .redAccent,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        VerticalDivider(
                                                          width: 2,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: <Widget>[
                                                              Container(
                                                                child: Text(
                                                                  'Recovered',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .lightGreenAccent,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                child:
                                                                    McCountingText(
                                                                  begin: 0,
                                                                  end: coronaProvider
                                                                      .coronaWorld
                                                                      .recovered
                                                                      .toDouble(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .lightGreenAccent,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        VerticalDivider(
                                                          width: 2,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    height: 250,
                                    child: ListView.builder(
                                        controller: _scrollController,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: coronaProvider
                                            .coronaCountries.length,
                                        itemBuilder: (context, index) {
                                          Color activeColor =
                                              Colors.redAccent.withOpacity(0.5);
                                          return GestureDetector(
                                            onTap: () => _goToLocation(
                                              CameraPosition(
                                                tilt: 10.5,
                                                zoom: 4.5,
                                                bearing: 4,
                                                target: LatLng(
                                                    coronaProvider
                                                        .coronaCountries[index]
                                                        .countryInfo
                                                        .lat
                                                        .toDouble(),
                                                    coronaProvider
                                                        .coronaCountries[index]
                                                        .countryInfo
                                                        .long
                                                        .toDouble()),
                                              ),
                                            ),
                                            child: CountriesCard(
                                              countryName1: coronaProvider
                                                  .coronaCountries[index]
                                                  .country,
                                              countryName2:
                                                  '${coronaProvider.coronaCountries[index].countryInfo.iso2}',
                                              coronaCases: coronaProvider
                                                  .coronaCountries[index].cases,
                                              deaths: coronaProvider
                                                  .coronaCountries[index]
                                                  .deaths,
                                              recovered: coronaProvider
                                                  .coronaCountries[index]
                                                  .recovered,
                                              todayCases: coronaProvider
                                                  .coronaCountries[index]
                                                  .todayCases,
                                              todayDeaths: coronaProvider
                                                  .coronaCountries[index]
                                                  .todayDeaths,
                                              critical: coronaProvider
                                                  .coronaCountries[index]
                                                  .critical,
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                        child: Container(
                          height: 55,
                          width: 55,
                          child: RaisedButton(
                            color: Colors.grey[800].withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.refresh,
                                color: mainColor,
                              ),
                            ),
                            onPressed: () {
                              coronaProvider.getCoronaData();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Color _whichCircleColor({int cases, int deaths}) {
    if (cases < 1) {
      return Colors.green.withOpacity(0.5);
    } else if (deaths < 1) {
      return Colors.amber.withOpacity(0.5);
    } else {
      return Colors.red.withOpacity(0.5);
    }
  }

  Future<void> _goToLocation(CameraPosition cameraPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  double _whichCircleRadius({int cases, int deaths}) {
    if (cases < 1) {
      return 30000.0;
    } else if (deaths < 1) {
      return 30000.0;
    } else {
      if ((cases + 1) * 1000 >= 300000) {
        return 100000.0;
      }
      return (cases + 1) * 300.0;
    }
  }
}
