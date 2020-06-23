class Patient {
  int id;
  String fullname;
  String username;
  String email;

  Patient({this.id,this.fullname, this.username, this.email});

  factory Patient.fromJson(Map<String, dynamic> json){
    return Patient(
      id: json['id'] as int,
      fullname: json['fullname'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }
}