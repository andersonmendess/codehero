import 'package:code_hero/models/character.dart';

class CharacterResponse {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<CharacterModel> results;

  CharacterResponse({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    final List<CharacterModel> characters = (json['results'] as List)
        .map((character) => CharacterModel.fromJson(character))
        .toList();

    return CharacterResponse(
      offset: json['offset'],
      limit: json['limit'],
      total: json['total'],
      count: json['count'],
      results: characters,
    );
  }
}
