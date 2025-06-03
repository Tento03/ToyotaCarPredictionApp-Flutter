import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:toyotacarpriceprediction/model/History.dart';

class Historypage extends StatefulWidget {
  const Historypage({super.key});

  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {
  final Box historyBox = Hive.box<History>('historyBox');
  final yearController = TextEditingController();
  final modelController = TextEditingController();

  void showUserDialog({History? history, int? index}) {
    if (history != null) {
      yearController.text = history.year;
      modelController.text = history.model;
    } else {
      yearController.clear();
      modelController.clear();
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Edit User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: yearController,
                  decoration: InputDecoration(
                    labelText: 'Year',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: modelController,
                  decoration: InputDecoration(
                    labelText: 'Model',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (history != null) {
                    history.year = yearController.text;
                    history.model = modelController.text;
                    history.save();
                    Navigator.pop(context);
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
    );
  }

  void deleteHistory(int index) {
    historyBox.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History Page',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: ValueListenableBuilder(
        valueListenable: historyBox.listenable(),
        builder: (context, value, child) {
          if (value.values.isEmpty) {
            return Center(child: Text('History is Empty'));
          }
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              var history = value.getAt(index) as History;
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 4,
                child: ListTile(
                  title: Text(history.model),
                  subtitle: Text(
                    'Year:${history.year}, Price:${history.prediction}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed:
                            () =>
                                showUserDialog(history: history, index: index),
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => deleteHistory(index),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
