import 'package:flutter/material.dart';
import 'package:Corona_App/HomePage.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19 Tracker',
      theme: ThemeData(
        primaryColor:Colors.black,
      ),
      home: HomePage(),
           
            
          );
        }
      }
      
      