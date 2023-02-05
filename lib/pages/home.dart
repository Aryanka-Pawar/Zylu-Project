import 'package:flutter/material.dart';
import 'package:zylu/pages/addEmployee.dart';
import '../models/employee.dart';
import '../services/sql.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var db = DatabaseHelper();

  void _navigateToAddEmployeePage() async{
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AddEmployee()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List>(
        future: db.getUserEmployee(),
        initialData: const [],
        builder: (context, snapshot) {
          return snapshot.hasData ?
          ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: snapshot.data?.length,
            itemBuilder: (context, i) {
              int duration = 2023 - int.parse(snapshot.data![i].employeeJoined.toString());
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor:  duration >5 ? Colors.green: Colors.grey,
                ),
                title: Text(snapshot.data![i].employeeName),
                trailing: Text(snapshot.data![i].employeeJoined),
              );
            },
          ) :
          const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddEmployeePage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}