import 'dart:convert';
import 'package:Corona_App/World.dart';
import 'package:Corona_App/india.dart';
import 'package:Corona_App/model/Tcases.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://disease.sh/v3/covid-19/all";
  Future<Tcases> getJsonData;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<Tcases> getData() async {
    var response = await http.get(
      Uri.encodeFull(url),
    );

    if (response.statusCode == 200) {
      final convertDataJSON = jsonDecode(response.body);
      print(response.body);
      return Tcases.fromJson(convertDataJSON);
    } else {
      throw Exception('try to Reload');
    }
  }

//  NAVIGATE TO ALL COUNTRYS
  navigateToCountry() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => World()),
    );
  }

  //NAVIGATE TO INDIA
  navigateToStats() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => India()),
    );
  }

    //NAVIGATE TO Who URL

    _launchURL() async {
  const url = 'https://miththilan.me';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

/*
    navigateToWHO(url) async {
      if(await canLaunch(url) ){
        await launch(url);
      }
      else
      {
        Text('Link is not Working $url');
      }
    }
*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID-19 Tracker"),
        backgroundColor: Color(0xFF152238),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 50)),
                        Text(
                          'Stay',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Card(
                          color: Color(0xFFfe9900),
                          child: Text(
                            'Home',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]),
                ),

                Padding(padding: EdgeInsets.only(top: 30)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Worldwide Statistics',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    OutlineButton(
                      color: Colors.black,
                      borderSide: BorderSide(color: Color(0xFFfe9900)),
                      onPressed: () {},
                      child: Text(
                        "India Statistics",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFfe9900),
                        ),
                      ),
                    ),
                  ],
                ),

                //GET DATA FROM API

                FutureBuilder<Tcases>(
                    future: getData(),
                    builder: (BuildContext context, SnapShot) {
                      if (SnapShot.hasData) {
                        final covid = SnapShot.data;
                        return Column(
                          children: [
                            Card(
                              color: Color(0xFF292929),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "${covid.cases}",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 23.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${covid.deaths}",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 23.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${covid.recovered}",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 23.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (SnapShot.hasError) {
                        return Text(SnapShot.error.toString());
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),

                //PADDING

                // Padding(padding: EdgeInsets.only(top: 8)),

                //LABELS FOR API DETAILS

                Container(
                  child: Card(
                    color: Color(0xFF292929),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Cases",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Deaths",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Recovered",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // PADDING

                Padding(padding: EdgeInsets.only(top: 20)),

                //FIRST TWO SELECTIONS

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        child: Container(
                          color: Color(0xFF292929),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage("images/india.png"),
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                OutlineButton(
                                  borderSide:
                                      BorderSide(color: Color(0xFFfe990)),
                                  onPressed: ()=>navigateToStats(),
                                  child: Text(
                                    "India StatsWise",
                                    style: TextStyle(
                                      color: Color(0xFFfe9900),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          color: Color(0xFF292929),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage("images/world.png"),
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                OutlineButton(
                                  borderSide:
                                      BorderSide(color: Color(0xFFfe990)),
                                  onPressed: () => navigateToCountry(),
                                  child: Text(
                                    "Worldwide Statistic",
                                    style: TextStyle(
                                      color: Color(0xFFfe9900),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //PADDING

                Padding(padding: EdgeInsets.only(top: 20)),

                //3rd SELECTION

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: Container(
                        color: Color(0xFF292929),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage("images/myth.png"),
                                height: 90.0,
                                width: 90.0,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              OutlineButton(
                                borderSide: BorderSide(color: Color(0xFFfe990)),
                                onPressed: ()=>_launchURL(),
                                child: Text(
                                  "Myth Buster",
                                  style: TextStyle(
                                    color: Color(0xFFfe9900),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
