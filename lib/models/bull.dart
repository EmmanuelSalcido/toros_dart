class Bull {
  final String id;
  final String num;

  // Convertimos el constructor en constante
  const Bull({required this.id, required this.num});

  factory Bull.fromJson(Map<String, dynamic> json) {
    return Bull(
      id: json['id'].toString(),  // Convertimos a string por seguridad
      num: json['num'].toString(), // Convertimos a string por seguridad
    );
  }
}

// Definir un Bull vacío
const Bull emptyBull = Bull(id: '', num: '');
