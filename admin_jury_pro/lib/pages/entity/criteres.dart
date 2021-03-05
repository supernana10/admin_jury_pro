import 'dart:convert';

class Criteres {
  int criteres_id;
  String criteres_libelle;
  int criteres_bareme;
  int evenement_id;
  Criteres({
    this.criteres_id,
    this.criteres_libelle,
    this.criteres_bareme,
    this.evenement_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'criteres_id': criteres_id,
      'criteres_libelle': criteres_libelle,
      'criteres_bareme': criteres_bareme,
      'evenement_id': evenement_id,
    };
  }

  factory Criteres.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Criteres(
      criteres_id: map['criteres_id'],
      criteres_libelle: map['criteres_libelle'],
      criteres_bareme: map['criteres_bareme'],
      evenement_id: map['evenement_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Criteres.fromJson(String source) =>
      Criteres.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Criteres(criteres_id: $criteres_id, criteres_libelle: $criteres_libelle, criteres_bareme: $criteres_bareme, evenement_id: $evenement_id)';
  }

  Criteres copyWith({
    int criteres_id,
    String criteres_libelle,
    int criteres_bareme,
    int evenement_id,
  }) {
    return Criteres(
      criteres_id: criteres_id ?? this.criteres_id,
      criteres_libelle: criteres_libelle ?? this.criteres_libelle,
      criteres_bareme: criteres_bareme ?? this.criteres_bareme,
      evenement_id: evenement_id ?? this.evenement_id,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Criteres &&
        o.criteres_id == criteres_id &&
        o.criteres_libelle == criteres_libelle &&
        o.criteres_bareme == criteres_bareme &&
        o.evenement_id == evenement_id;
  }

  @override
  int get hashCode {
    return criteres_id.hashCode ^
        criteres_libelle.hashCode ^
        criteres_bareme.hashCode ^
        evenement_id.hashCode;
  }
}
