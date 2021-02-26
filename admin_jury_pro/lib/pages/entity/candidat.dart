import 'dart:convert';

class Candidat {
  int candidat_id;
  int candidat_code;
  String candidat_nom;
  String candidat_prenom;
  String candidat_photo;
  String candidat_email;
  int candidat_telephone;
  int evenement_id;
  Candidat({
    this.candidat_id,
    this.candidat_code,
    this.candidat_nom,
    this.candidat_prenom,
    this.candidat_photo,
    this.candidat_email,
    this.candidat_telephone,
    this.evenement_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'candidat_id': candidat_id,
      'candidat_code': candidat_code,
      'candidat_nom': candidat_nom,
      'candidat_prenom': candidat_prenom,
      'candidat_photo': candidat_photo,
      'candidat_email': candidat_email,
      'candidat_telephone': candidat_telephone,
      'evenement_id': evenement_id,
    };
  }

  factory Candidat.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Candidat(
      candidat_id: map['candidat_id'],
      candidat_code: map['candidat_code'],
      candidat_nom: map['candidat_nom'],
      candidat_prenom: map['candidat_prenom'],
      candidat_photo: map['candidat_photo'],
      candidat_email: map['candidat_email'],
      candidat_telephone: map['candidat_telephone'],
      evenement_id: map['evenement_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Candidat.fromJson(String source) =>
      Candidat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Candidat(candidat_id: $candidat_id, candidat_code: $candidat_code, candidat_nom: $candidat_nom, candidat_prenom: $candidat_prenom, candidat_photo: $candidat_photo, candidat_email: $candidat_email, candidat_telephone: $candidat_telephone, evenement_id: $evenement_id)';
  }

  Candidat copyWith({
    int candidat_id,
    int candidat_code,
    String candidat_nom,
    String candidat_prenom,
    String candidat_photo,
    String candidat_email,
    int candidat_telephone,
    int evenement_id,
  }) {
    return Candidat(
      candidat_id: candidat_id ?? this.candidat_id,
      candidat_code: candidat_code ?? this.candidat_code,
      candidat_nom: candidat_nom ?? this.candidat_nom,
      candidat_prenom: candidat_prenom ?? this.candidat_prenom,
      candidat_photo: candidat_photo ?? this.candidat_photo,
      candidat_email: candidat_email ?? this.candidat_email,
      candidat_telephone: candidat_telephone ?? this.candidat_telephone,
      evenement_id: evenement_id ?? this.evenement_id,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Candidat &&
      o.candidat_id == candidat_id &&
      o.candidat_code == candidat_code &&
      o.candidat_nom == candidat_nom &&
      o.candidat_prenom == candidat_prenom &&
      o.candidat_photo == candidat_photo &&
      o.candidat_email == candidat_email &&
      o.candidat_telephone == candidat_telephone &&
      o.evenement_id == evenement_id;
  }

  @override
  int get hashCode {
    return candidat_id.hashCode ^
      candidat_code.hashCode ^
      candidat_nom.hashCode ^
      candidat_prenom.hashCode ^
      candidat_photo.hashCode ^
      candidat_email.hashCode ^
      candidat_telephone.hashCode ^
      evenement_id.hashCode;
  }
}
