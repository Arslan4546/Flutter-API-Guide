import 'package:covid19_app/Screens/details_screen.dart';
import 'package:covid19_app/Services/Utilities/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
        body: SafeArea(
          child: Column(
            children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    child: TextFormField(
                    onChanged: (value){
                      setState(() {

                      });
                    },
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "search with countries name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                    ),
                  ),
              Expanded(
                child: FutureBuilder(
                    future: stateServices.fetchCountriesRecord(),
                    builder: (context,AsyncSnapshot<List<dynamic>>snapshot) {
                  if(!snapshot.hasData){
                   return ListView.builder(
                     itemCount: 4,
                       itemBuilder: (context, index){
                         return Shimmer.fromColors(
                           baseColor: Colors.grey.shade700,
                           highlightColor: Colors.grey.shade100,
                           child: Column(
                             children: [
                               ListTile(
                                 leading: const CircleAvatar(
                                   radius:35,
                                 ),
                                 title: Container(height: 10,width: 89,color: Colors.white,),
                                 subtitle: Container(height: 10,width: 89,color: Colors.white,),
                               )
                             ],
                           ),
                         );
                       });
                  }else{
                
                    return ListView.builder(
                        itemCount:snapshot.data!.length,
                        itemBuilder: (context,index){

                          String name = snapshot.data![index]["country"];

                          if(searchController.text.isEmpty){
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                        name:snapshot.data![index]["country"],
                                        image: snapshot.data![index]["countryInfo"]["flag"],
                                        todayRecovered:snapshot.data![index]["todayRecovered"],
                                        critical:snapshot.data![index]["critical"],
                                        todayCases:snapshot.data![index]["todayCases"],
                                        active:snapshot.data![index]["active"],
                                        cases:snapshot.data![index]["cases"],
                                        todayDeaths:snapshot.data![index]["todayDeaths"],
                                        tests:snapshot.data![index]["tests"],
                                      )));
                                    },
                                    child: ListTile(
                                      leading:CircleAvatar(
                                        radius:35,
                                    backgroundImage:NetworkImage(
                                                              snapshot.data![index]["countryInfo"]["flag"],
                                                              ),
                                    ),
                                      title:Text(snapshot.data![index]["country"]),
                                      subtitle:Text(snapshot.data![index]["cases"].toString()),
                                    
                                    
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                          else if(name.toLowerCase().contains(searchController.text.toString())){
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                        name:snapshot.data![index]["country"],
                                        image: snapshot.data![index]["countryInfo"]["flag"],
                                        todayRecovered:snapshot.data![index]["todayRecovered"],
                                        critical:snapshot.data![index]["critical"],
                                        todayCases:snapshot.data![index]["todayCases"],
                                        active:snapshot.data![index]["active"],
                                        cases:snapshot.data![index]["cases"],
                                        todayDeaths:snapshot.data![index]["todayDeaths"],
                                        tests:snapshot.data![index]["tests"],
                                      )));
                                    },
                                    child: ListTile(
                                      leading:CircleAvatar(
                                        radius:35,
                                        backgroundImage:NetworkImage(
                                          snapshot.data![index]["countryInfo"]["flag"],
                                        ),
                                      ),
                                      title:Text(snapshot.data![index]["country"]),
                                      subtitle:Text(snapshot.data![index]["cases"].toString()),


                                    ),
                                  ),
                                )
                              ],
                            );

                          }else{
                           return Container();
                          }

                        }
                    );
                  }
                }),
              )
            ],
          ),
        ),
      );

  }
}
