class ModelDTO {
  int id;
  String title;
  String description;
  String imgLink;
  String email;

  ModelDTO({
    required this.id,
    required this.title,
    required this.description,
    required this.imgLink,
    required this.email,
  });

  factory ModelDTO.fromJson(Map<String, dynamic> json) {
    return ModelDTO(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      imgLink: json['img_link'] == null ? "" : json['img_link'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'img_link': imgLink,
      'email': email,
    };
  }
}
