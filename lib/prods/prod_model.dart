class Prod {
  Prod({
    required this.nome,
    required this.loja,
    required this.preco,
  });

  final String nome;
  final List<String> loja;
  final List<double> preco;

  // 'kero': 'kero.jpg',
  static final nomeDelojas = {
    'deskontao': 'deskontao.png',
    'kero': 'kero3.png',
    'alimenta angola': 'alimenta angola.png',
    'maxi': 'maxi.png',
    'fresmart': 'fresmart2.jpg',
    'angomart': 'angomart2.png',
    'kibabo': 'kibabo2.png',
    'shoprite': 'shoprite.png',
  };
  static final lojas = [
    'shoprite',
    'deskontao',
    'kero',
    'alimenta angola',
    'maxi',
    'fresmart',
    'angomart',
    'kibabo'
  ];
  //   {
  //     'nome': 'deskontao',
  //     'img': 'deskontao.png',
  //   },
  //   {
  //     'nome': 'kero',
  //     'img': 'kero.png',
  //   },
  //   {
  //     'nome': 'alimenta angola',
  //     'img': 'alimenta angola.png',
  //   },
  //   {
  //     'nome': 'maxi',
  //     'img': 'maxi.png',
  //   },
  //   {
  //     'nome': 'fresmart',
  //     'img': 'fresmart.png',
  //   },
  //   {
  //     'nome': 'shoprite',
  //     'img': 'shoprite.png',
  //   }
  // ];

  factory Prod.fromJson(Map<String, dynamic> json) {
    return Prod(
      nome: json['data']['nome'],
      loja: [json['data']['loja']],
      preco: json['data']['preco'].toDouble(),
    );
  }

  static getImg(String nomeLoja) {
    return nomeDelojas[nomeLoja];
  }
}
