class User {
  User({
    required this.nome,
    this.tipo,
    required this.senha,
  });

  final String nome;
  final String? tipo;
  final String senha;

  // 'kero': 'kero.jpg',
  static final tiposUser = {'super_admin': '', 'admin_loja': '', 'cliente': ''};
  static final tipos = ['super_admin', 'admin_loja', 'cliente'];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nome: json['data']['nome'],
      tipo: json['data']['tipo'],
      senha: json['data']['senha'],
    );
  }
}
