import 'package:flutter/material.dart';
import 'package:second_project_api_practice/API_Data/model_class.dart';
import 'package:second_project_api_practice/API_Data/userAPI.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserAPI userAPI = UserAPI();
  Future<List<UserAPIModel>>? _listOfuserFutureDat;
  Future<UserAPIModel>? _singleUserFutureData;

  void _insertUserData() async {
    // this is the data we give in the constructor to ad the data in the API
    // you can perform the update api fucntion same as it is and delete fucntion is also same as it is
    UserAPIModel userAPIModel = UserAPIModel(
      id: 5,
      name: "Arslan",
      companyName: "Marketox",
      location: "BWP",
    );
    var isInserted = await userAPI.insertUserAPI(userAPIModel);
    if (isInserted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Your Data is inserted")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Your Data is not inserted")));
    }
  }

  @override
  void initState() {
    super.initState();
    // _listOfuserFutureDat = userAPI.fetchUserAPI();
    _singleUserFutureData = userAPI.fetchUserAPIById("5");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () {
            _insertUserData();
            print("This fucntion is calling you!");
          },
          icon: Icon(Icons.abc),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder(
            future: _singleUserFutureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final user = snapshot.data!;
                return Center(child: Text(user.name));
                // return ListView.builder(
                //   itemCount: user.length,
                //   itemBuilder: (context, index) {
                //     return Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: SizedBox(
                //         height: 100,
                //         width: double.infinity,
                //         child: Column(
                //           children: [
                //             Text(" Name : ${user[index].name}"),
                //             Text(" Company : ${user[index].companyName}"),
                //             Text(" Location : ${user[index].location}"),
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
