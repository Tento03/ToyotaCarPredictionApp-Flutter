import 'package:flutter/material.dart';
import 'package:toyotacarpriceprediction/ui/ScanPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hello,\nWelcome To Toyota Car Price Prediction',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Scanpage()),
                  ),
              label: Text('Predict'),
              icon: Icon(Icons.grading_outlined),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lime,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Toyota Car',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Text('Toyota Car Type'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text('Toyota Car Type'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text('Toyota Car Type'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
