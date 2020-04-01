import 'package:corona_virus_map/src/data_provider/corona_data.dart';
import 'package:corona_virus_map/src/screens/map_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecialPage extends StatefulWidget {
  @override
  _SpecialPageState createState() => _SpecialPageState();
}

class _SpecialPageState extends State<SpecialPage> {
  String whichCountry = 'none';

  @override
  Widget build(BuildContext context) {
    CoronaProvider coronaProvider =
        Provider.of<CoronaProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          bottom: false,
          child: Container(
            child: Container(
              margin: EdgeInsets.only(top: 2, bottom: 5, right: 4, left: 4),
              padding: EdgeInsets.only(top: 5),
              child: FutureBuilder(
                  future: coronaProvider.getCoronaData(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator();
                    }

                    return MapPage();
                  }),
            ),
          ),
        ));
  }
}
