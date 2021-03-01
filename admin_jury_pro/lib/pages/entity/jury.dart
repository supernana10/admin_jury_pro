import 'dart:convert';

class Jury {
  int jury_id;
  int jury_code;
  String jury_nom_complet;
  String jury_email;
  int jury_telephone;
  int evenement_id;
  Jury({
    this.jury_id,
    this.jury_code,
    this.jury_nom_complet,
    this.jury_email,
    this.jury_telephone,
    this.evenement_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'jury_id': jury_id,
      'jury_code': jury_code,
      'jury_nom_complet': jury_nom_complet,
      'jury_email': jury_email,
      'jury_telephone': jury_telephone,
      'evenement_id': evenement_id,
    };
  }

  factory Jury.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Jury(
      jury_id: map['jury_id'],
      jury_code: map['jury_code'],
      jury_nom_complet: map['jury_nom_complet'],
      jury_email: map['jury_email'],
      jury_telephone: map['jury_telephone'],
      evenement_id: map['evenement_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Jury.fromJson(String source) => Jury.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Jury(jury_id: $jury_id, jury_code: $jury_code, jury_nom_complet: $jury_nom_complet ,jury_email: $jury_email, jury_telephone: $jury_telephone, evenement_id: $evenement_id)';
  }

  Jury copyWith({
    int jury_id,
    int jury_code,
    String jury_nom_complet,
    String jury_prenom,
    String jury_photo,
    String jury_email,
    int jury_telephone,
    int evenement_id,
  }) {
    return Jury(
      jury_id: jury_id ?? this.jury_id,
      jury_code: jury_code ?? this.jury_code,
      jury_nom_complet: jury_nom_complet ?? this.jury_nom_complet,
      jury_email: jury_email ?? this.jury_email,
      jury_telephone: jury_telephone ?? this.jury_telephone,
      evenement_id: evenement_id ?? this.evenement_id,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Jury &&
        o.jury_id == jury_id &&
        o.jury_code == jury_code &&
        o.jury_nom_complet == jury_nom_complet &&
        o.jury_email == jury_email &&
        o.jury_telephone == jury_telephone &&
        o.evenement_id == evenement_id;
  }

  @override
  int get hashCode {
    return jury_id.hashCode ^
        jury_code.hashCode ^
        jury_nom_complet.hashCode ^
        jury_email.hashCode ^
        jury_telephone.hashCode ^
        evenement_id.hashCode;
  }
}
