import 'dart:convert';

class Evenement {
  int evenementId;
  String evenementNom;
  String evenementType;
  String evenementDateDebut;
  String evenementDateFin;
  String evenementphoto;
  Evenement({
    this.evenementId,
    this.evenementNom,
    this.evenementType,
    this.evenementDateDebut,
    this.evenementDateFin,
    this.evenementphoto,
  });


  Map<String, dynamic> toMap() {
    return {
      'evenementId': evenementId,
      'evenementNom': evenementNom,
      'evenementType': evenementType,
      'evenementDateDebut': evenementDateDebut,
      'evenementDateFin': evenementDateFin,
      'evenementphoto': evenementphoto,
    };
  }

  factory Evenement.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Evenement(
      evenementId: map['evenementId'],
      evenementNom: map['evenementNom'],
      evenementType: map['evenementType'],
      evenementDateDebut: map['evenementDateDebut'],
      evenementDateFin: map['evenementDateFin'],
      evenementphoto: map['evenementphoto'],
    );
  }

  factory Evenement.fromJson(String source) => Evenement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Evenement(evenementId: $evenementId, evenementNom: $evenementNom, evenementType: $evenementType, evenementDateDebut: $evenementDateDebut, evenementDateFin: $evenementDateFin, evenementphoto: $evenementphoto)';
  }

}
