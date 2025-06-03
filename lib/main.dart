import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toyotacarpriceprediction/model/History.dart';
import 'package:toyotacarpriceprediction/ui/HistoryPage.dart';
import 'package:toyotacarpriceprediction/ui/HomePage.dart';
import 'package:toyotacarpriceprediction/ui/InfoPage.dart';
import 'package:toyotacarpriceprediction/ui/ScanPage.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryAdapter());
  await Hive.openBox<History>('historyBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DrawerPage());
  }
}

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toyota Car Price Prediction'),
        titleTextStyle: TextStyle(fontSize: 25),
        backgroundColor: Colors.blueGrey,
      ),
      body: Homepage(),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightGreen),
              child: Center(child: Text('Toyota')),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                  ),
            ),
            ListTile(
              title: Text('Scan'),
              leading: Icon(Icons.scanner),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Scanpage()),
                  ),
            ),
            ListTile(
              title: Text('History'),
              leading: Icon(Icons.history),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Historypage()),
                  ),
            ),
            ListTile(
              title: Text('Info'),
              leading: Icon(Icons.info),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Infopage()),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
