class Employee {

  late final String _employeeId;
  late final String _employeeName;
  late final String _employeeJoined;

  Employee(this._employeeId, this._employeeName, this._employeeJoined);

  Employee.map(dynamic obj) {
    _employeeId = obj['employeeId'];
    _employeeName = obj['employeeName'];
    _employeeJoined = obj['employeeJoined'];
  }

  String get employeeId => _employeeId;
  String get employeeName => _employeeName;
  String get employeeJoined => _employeeJoined;

  Employee.fromMap(dynamic obj) {
    _employeeId = obj["employeeId"];
    _employeeName = obj["employeeName"];
    _employeeJoined = obj["employeeJoined"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["employeeId"] = _employeeId;
    map["employeeName"] = _employeeName;
    map["employeeJoined"] = _employeeJoined;
    return map;
  }
}