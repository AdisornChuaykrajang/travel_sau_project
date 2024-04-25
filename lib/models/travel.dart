class Travel {
  //ตัวแปรเก็บข้อมูลที่สอดรับกับตารางใน DB
  int? id;
  String? pictureTravel;
  String? placeTravel;
  String? costTravel;
  String? dateTravel;
  String? dayTravel;
  String? locationTravel;

  Travel({
    this.id,
    this.placeTravel,
    this.costTravel,
    this.dateTravel,
    this.dayTravel,
    this.locationTravel,
    this.pictureTravel,
  });

  factory Travel.fromMap(Map<String, dynamic> json) {
    return Travel(
      id: json['id'],
      placeTravel: json['placeTravel'],
      costTravel: json['costTravel'],
      dateTravel: json['dateTravel'],
      dayTravel: json['dayTravel'],
      locationTravel: json['locationTravel'],
      pictureTravel: json['pictureTravel']
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'placeTravel': placeTravel,
      'costTravel': costTravel,
      'dateTravel': dateTravel,
      'dayTravel': dayTravel,
      'locationTravel': locationTravel,
      'pictureTravel':pictureTravel
    };
  }
}
