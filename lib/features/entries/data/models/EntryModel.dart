import 'package:clean_architecture_demo_2/features/entries/domain/entities/entry.dart';

class EntryModel extends Entry {
  const EntryModel({
    required String api,
    required String description,
    required String auth,
    required bool https,
    required String cors,
    required String link,
    required String category,
  }) : super(
          api: api,
          description: description,
          auth: auth,
          https: https,
          cors: cors,
          link: link,
          category: category,
        );
  factory EntryModel.fromJson(Map<String, dynamic> json) => EntryModel(
        api: json["API"],
        description: json["Description"],
        auth: json["Auth"],
        https: json["HTTPS"],
        cors: json["Cors"],
        link: json["Link"],
        category: json["Category"],
      );

  Map<String, dynamic> toJson() => {
        "API": api,
        "Description": description,
        "Auth": auth,
        "HTTPS": https,
        "Cors": cors,
        "Link": link,
        "Category": category,
      };
}
