import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zylu/models/employee.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;
  final String tableEmployee = "Employee";

  final String columnEmployeeId = "employeeId";
  final String columnEmployeeName = "employeeName";
  final String columnEmployeeJoined = "employeeJoined";

  Future<Database> get db async => _db ??= await initDb();

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Employee(id INTEGER PRIMARY KEY, employeeId TEXT, employeeName TEXT, employeeJoined TEXT)");
    print("Table is created");
  }

  //insertion
  Future<int> saveEmployee(Employee employee) async {
    print("\n Here \n\n");
    var dbClient = await db;
    int res = await dbClient.insert("Employee", employee.toMap());
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Employee');
    print(list);
    return list.elementAt(list.length-1)["id"];
  }

  //deletion
  Future<int> deleteEmployee(Employee employee) async {
    var dbClient = await db;
    int res = await dbClient.delete("Employee");
    return res;
  }

  //select
  Future<List>? getUserEmployee() async {
    var dbClient = await db;
    String sql;
    sql = 'SELECT * FROM Employee';

    var result = await dbClient.rawQuery(sql);
    if (result.isEmpty) {
      return [];
    }

    List list = result.map((item) {
      return Employee.fromMap(item);
    }).toList();

    print(result);
    return list;
  }

}