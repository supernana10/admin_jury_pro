import 'dart:convert';

class groupe {
  int groupe_id;
  int groupe_code;
  String groupe_nom;
  String groupe_photo;
  int evenement_id;
  groupe({
    this.groupe_id,
    this.groupe_code,
    this.groupe_nom,
    this.groupe_photo,
    this.evenement_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'groupe_id': groupe_id,
      'groupe_code': groupe_code,
      'groupe_nom': groupe_nom,
      'groupe_photo': groupe_photo,
      'evenement_id': evenement_id,
    };
  }

  factory groupe.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return groupe(
      groupe_id: map['groupe_id'],
      groupe_code: map['groupe_code'],
      groupe_nom: map['groupe_nom'],
      groupe_photo: map['groupe_photo'],
      evenement_id: map['evenement_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory groupe.fromJson(String source) => groupe.fromMap(json.decode(source));

  @override
  String toString() {
    return 'groupe(groupe_id: $groupe_id, groupe_code: $groupe_code, groupe_nom: $groupe_nom ,groupe_photo: $groupe_photo, evenement_id: $evenement_id)';
  }

  groupecopyWith({
    int groupe_id,
    int groupe_code,
    String groupe_nom,
    String groupe_photo,
    int evenement_id,
  }) {
    return groupe(
      groupe_id: groupe_id ?? this.groupe_id,
      groupe_code: groupe_code ?? this.groupe_code,
      groupe_nom: groupe_nom ?? this.groupe_nom,
      groupe_photo: groupe_photo ?? this.groupe_photo,
      evenement_id: evenement_id ?? this.evenement_id,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is groupe &&
        o.groupe_id == groupe_id &&
        o.groupe_code == groupe_code &&
        o.groupe_nom == groupe_nom &&
        o.groupe_photo == groupe_photo &&
        o.evenement_id == evenement_id;
  }

  @override
  int get hashCode {
    return groupe_id.hashCode ^
        groupe_code.hashCode ^
        groupe_nom.hashCode ^
        groupe_photo.hashCode ^
        evenement_id.hashCode;
  }
}
