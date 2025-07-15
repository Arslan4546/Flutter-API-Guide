import 'package:covid19_app/Screens/worldStats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  String name;
  String image;
  int todayRecovered,todayDeaths,cases,todayCases,critical,active,tests;

   DetailScreen({
     required this.name,
     required this.image,
     required this.todayRecovered,
     required this.todayDeaths,
     required this.cases,
     required this.todayCases,
     required this.critical,
     required this.active,
     required this.tests
   });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
           children: [
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                              child: Card(
                                child:  Column(
                                  children: [
                                    ReuseAbleRow(title: "Total Cases",value: widget.cases.toString(),),
                                    ReuseAbleRow(title: "Total Recovered",value: widget.todayRecovered.toString(),),
                                    ReuseAbleRow(title: "Total Deaths" ,value: widget.todayDeaths.toString(),),
                                    ReuseAbleRow(title: "Today Cases",value: widget.todayCases.toString(),),
                                    ReuseAbleRow(title: "Critical",value: widget.critical.toString(),),
                                    ReuseAbleRow(title: "Active",value: widget.active.toString(),),
                                    ReuseAbleRow(title: "Test",value: widget.tests.toString(),),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.02),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(widget.image),
                              ),
                            )
                          ],
                        )
                            ],
      )
    );
  }
}

