import 'package:flutter/material.dart';
import '../services/sql.dart';
import '../models/employee.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {

  DateTime initialDateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  TextEditingController employeeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Employee"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 25,),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Employee Name",
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    cursorColor: Colors.black,
                    maxLength: 20,
                    validator: (val) => (val==null||val.isEmpty) ?'Enter The Employee Name!' : null,
                    controller: employeeEditingController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEmployee,
        tooltip: 'Add Employee',
        child: const Icon(Icons.date_range),
      ),
    );
  }

  void _addEmployee() async{
    if(_formKey.currentState!.validate()){
      await pickDateTime(context);
      DateTime time = DateTime.now();
      var employee = Employee(time.microsecondsSinceEpoch.toString(), employeeEditingController.text, initialDateTime.year.toString());
      var db = DatabaseHelper();
      await db.saveEmployee(employee);
      Navigator.pop(context);
    }
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null){
      return;
    }
    setState(() {
      initialDateTime = DateTime(
        date.year,
        date.month,
        date.day,
      );
    });
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month+1),
    );
    if (newDate == null) {
      return initialDate;
    }
    return newDate;
  }

}
