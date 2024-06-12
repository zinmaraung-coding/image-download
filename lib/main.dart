import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      name: "firebaseApp",
      options: const FirebaseOptions(
          apiKey: "AIzaSyCIksWt78eiZcyW9MnO2kO9ElP-YyqsruE",
          appId: "1:869612970736:android:ba16112afe144cc7add835s",
          messagingSenderId: "869612970736",
          projectId: "fir-app-dee03",
          storageBucket: "fir-app-dee03.appspot.com"
      ),
    );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();
   futureFiles = FirebaseStorage.instance.ref("/files").listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Download App Example")),
      body: FutureBuilder<ListResult>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error Occurred"));
          } else if (snapshot.hasData) {
            final files = snapshot.data!.items;

            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];

                return ListTile(
                  title: Text(file.name),
                );
              },
            );
          } else {
            return Center(child: Text("No files found"));
          }
        },
      ),
    );
  }
}