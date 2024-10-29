import 'package:equatable/equatable.dart';

class Entry extends Equatable {
  final String api;
  final String description;
  final String auth;
  final bool https;
  final String cors;
  final String link;
  final String category;

  const Entry({
    required this.api,
    required this.description,
    required this.auth,
    required this.https,
    required this.cors,
    required this.link,
    required this.category,
  });

  @override
  List<Object?> get props => [
        api,
        description,
        auth,
        https,
        cors,
        link,
        category,
      ];
}
