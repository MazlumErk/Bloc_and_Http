import 'dart:convert';

Name nameFromJson(String str) => Name.fromJson(json.decode(str));

class Name {
  Name({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });
  int page;
  int perPage;
  int total;
  int totalPages;
  List<Data> data;
  Support support;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        support: Support.fromJson(json["support"]),
      );
}

class Data {
  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );
}

class Support {
  Support({
    required this.url,
    required this.text,
  });

  String url;
  String text;

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );
}
