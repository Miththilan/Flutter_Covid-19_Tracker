import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {
  final String url = "https://disease.sh/v3/covid-19/countries";

  Future<List> datas;

  Future<List> getData() async {
    var response = await Dio().get(url);
    return response.data;
  }

  @override
  void initState() {
    super.initState();
    datas = getData();
  }

  //  ALERT DIALOG BOX

  Future showcard(String cases, tdeaths, deaths, recover) async {
    await showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            backgroundColor: Color(0xFF363636),
            shape: RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(
                    "Total Cases : $cases",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    "Today Deaths : $tdeaths",
                    style: TextStyle(fontSize: 25, color: Colors.redAccent),
                  ),
                  Text(
                    "Total Deaths : $deaths",
                    style: TextStyle(fontSize: 25, color: Colors.red),
                  ),
                  Text(
                    "Total Recoverd : $recover",
                    style: TextStyle(fontSize: 25, color: Colors.green),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CountryWise Statistics"),
        backgroundColor: Color(0xFF152238),
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
            future: datas,
            builder: (BuildContext context, SnapShot) {
              if (SnapShot.hasData) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: 210,
                  itemBuilder: (BuildContext context, index) => SizedBox(
                    height: 50,
                    width: 50,
                    child: GestureDetector(
                      onTap: () => showcard(
                        SnapShot.data[index]['cases'].toString(),
                        SnapShot.data[index]['todayDeaths'].toString(),
                        SnapShot.data[index]['deaths'].toString(),
                        SnapShot.data[index]['recovered'].toString(),
                      ),
                      child: Card(
                        child: Container(
                          color: Color(0xFF292929),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Text(
                                    "Total Cases :${SnapShot.data[index]['cases'].toString()}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 18,
                                  ),
                                ),
                                Image(
                                  image: AssetImage("images/wdeath.png"),
                                  height: 85,
                                  width: 85,
                                ),
                                Text(
                                  SnapShot.data[index]['country'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
