import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class India extends StatefulWidget {
  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India> {
  final String url = "https://api.rootnet.in/covid19-in/stats/latest";

  Future<List> datas;

  Future<List> getData() async {
    var response = await Dio().get(url);
    return response.data['data']['regional'];
  }

  @override
  void initState() {
    super.initState();
    datas = getData();
  }

  //  ALERT DIALOG BOX

  Future showdetails(String cases, indian, deaths, recover) async {
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
                    "Total Confirmed : $cases",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    "Today Indian : $indian",
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
        title: Text("India Statistics"),
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
                  itemCount: 36,
                  itemBuilder: (BuildContext context, index) => SizedBox(
                    height: 50,
                    width: 50,
                    child: GestureDetector(
                      onTap: () => showdetails(
                        SnapShot.data[index]['totalConfirmed'].toString(),
                        SnapShot.data[index]['confirmedCasesIndian'].toString(),
                        SnapShot.data[index]['deaths'].toString(),
                        SnapShot.data[index]['discharged'].toString(),
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
                                  padding: EdgeInsets.only(top:16),
                                  child: Text(
                                    "Total Cases :${SnapShot.data[index]['totalConfirmed'].toString()}",
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
                                  image: AssetImage("images/cases.png"),
                                  height: 85,
                                  width: 85,
                                ),
                                Text(
                                  SnapShot.data[index]['loc'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
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
