import 'package:api_implementing/Layout/listviewbuilder.dart';
import 'package:flutter/material.dart';
import 'API_Service/api_service.dart';
import 'API_Service/model_class.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MyHomePage(title: "API Practice"));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService apiService = ApiService();
  //late Future<UserApi>? _futureAlbums;
  late Future<List<UserApi>> _futureAlbums;

  @override
  void initState() {
    super.initState();
    // _futureAlbums = apiService.getAlbumById(5);
    _futureAlbums = apiService.getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<List<UserApi>>(
        future: _futureAlbums,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No albums found.'));
          } else {
            return ListviewbuilderWidget(userList: snapshot.data!);
            // this is for fetcing using just single id
            // return Text(users!.name);

            // this is the manual calling api
            // return ListView.builder(
            //   itemCount: users!.lengthte
            //   itemBuilder: (context, index) {
            //     return Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: SizedBox(
            //         height: 300,
            //         width: double.infinity,
            //         child: Column(
            //           children: [
            //             Text(users[index].name),
            //             Text(users[index].email),
            //             Text(users[index].address),
            //             Text(users[index].companyName),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // );
          }
        },
      ),
    );
  }
}
