import 'package:equatable/equatable.dart';

class Pak extends Equatable {
  const Pak({
    required this.name,
    required this.version,
    required this.description,
    required this.author,
    required this.gameUrl,
    required this.logoUrl,
    required this.screenshots,
  });

  factory Pak.fromJson(Map<String, dynamic> json) {
    return Pak(
      name: json['name'] as String,
      version: json['version'] as String,
      description: json['description'] as String,
      author: json['author'] as String,
      gameUrl: json['gameUrl'] as String,
      logoUrl: json['logoUrl'] as String,
      screenshots: (json['screenshots'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  final String name;
  final String version;
  final String description;
  final String author;
  final String gameUrl;
  final String logoUrl;
  final List<String> screenshots;

  @override
  List<Object?> get props => [
    name,
    version,
    description,
    author,
    gameUrl,
    logoUrl,
    screenshots,
  ];
}
