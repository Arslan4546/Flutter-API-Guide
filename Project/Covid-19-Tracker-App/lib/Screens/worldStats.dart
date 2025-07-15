import 'package:covid19_app/Models/WorldStatesModel.dart';
import 'package:covid19_app/Screens/countries_list.dart';
import 'package:covid19_app/Services/Utilities/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {


  late final AnimationController _controller = AnimationController(

      duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];


  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return  Scaffold(
        body: SafeArea(
          child: Padding(
            padding:const  EdgeInsets.all(15.0),
            child: Column(
              children: [
           const  SizedBox(height: 30),
               FutureBuilder(
                   future: stateServices.fetchWorldRecords(), builder: (context,AsyncSnapshot<WorldStatesModel>snapshot) {
                 if(!snapshot.hasData){
                   return Expanded(
                       child:SpinKitCircle(
                        controller: _controller,
                         size: 50,
                         color: Colors.white,

                       ),
                   );
                 }else{
                     return Column(
                       children: [

                         PieChart(
                           dataMap:  {
                             "Total": double.parse(snapshot.data!.cases.toString()),
                             "Recovered": double.parse(snapshot.data!.recovered.toString()),
                             "Deaths": double.parse(snapshot.data!.deaths.toString()),

                           },
                           chartValuesOptions: const ChartValuesOptions(
                             showChartValuesInPercentage: true,
                           ),
                           chartRadius: MediaQuery.of(context).size.width / 3.3,
                           legendOptions:const  LegendOptions(
                             legendPosition: LegendPosition.left,
                           ),
                           animationDuration: const Duration(milliseconds: 1200),
                           chartType: ChartType.ring,
                           colorList: colorList,
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 25),
                           child: Card(
                             child: Column(
                               children: [
                                 ReuseAbleRow(title: "Total",value: (snapshot.data!.cases.toString()),),
                                 ReuseAbleRow(title: "Recovered",value:(snapshot.data!.recovered.toString()),),
                                 ReuseAbleRow(title: "Deaths",value: (snapshot.data!.deaths.toString()),),
                                 ReuseAbleRow(title: "Active",value: (snapshot.data!.active.toString()),),
                                 ReuseAbleRow(title: "Critical",value: (snapshot.data!.critical.toString()),),
                                 ReuseAbleRow(title: "Today Cases",value: (snapshot.data!.todayCases.toString()),),
                                 ReuseAbleRow(title: "Today Deaths",value: (snapshot.data!.todayDeaths.toString()),),
                                 ReuseAbleRow(title: "Today Recovered",value: (snapshot.data!.todayRecovered.toString()),),
                             
                               ],
                             ),
                           ),
                         ),
                         const   SizedBox(height: 10,),
                         GestureDetector(
                           child: Container(
                             height: 50,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: const Color(0xff1aa260)
                             ),
                             child: const Center(child: Text("Track Countries",style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.white
                             ),)),
                           
                           ),
                             onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> const CountriesList()));
                             },
                         )
                       ],
                     );
                 }
               }),




              ],
            ),
          ),
        ),
      );
  }
}

class ReuseAbleRow extends StatelessWidget {
  String title, value;
   ReuseAbleRow({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 10,left:10,right: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5,),

        ],
      ),
    );
  }
}
