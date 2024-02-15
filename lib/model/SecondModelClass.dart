
class SecondModelDTO  {
  int id;
  String title;
  String email;
  String description;


  SecondModelDTO({
    required this.id,
    required this.title,
    required this.email,
    required this.description,

  });

  factory SecondModelDTO.fromJson(Map<String, dynamic> json) {
    return SecondModelDTO(
      id: json['id'] as int,
      title: json['title'] as String,
      email: json['email'] as String,
      description: json['description'] as String,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'email': email,
      'description': description,

    };
  }
}
