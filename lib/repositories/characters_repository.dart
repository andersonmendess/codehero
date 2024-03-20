import 'package:code_hero/models/character_response.dart';
import 'package:code_hero/services/http_service.dart';
import 'package:dio/dio.dart';

class CharactersRepository {
  late final Dio _httpService;

  CharactersRepository() {
    _httpService = HttpService.build();
  }

  Future<CharacterResponse> getCharacters({
    int limit = 4,
    int offset = 0,
    String? nameStartsWith,
  }) async {
    final response = await _httpService.get(
      "/characters",
      queryParameters: {
        'limit': limit,
        'offset': offset,
        if (nameStartsWith != null) 'nameStartsWith': nameStartsWith,
      },
    );

    final data = response.data['data'];

    return CharacterResponse.fromJson(data);
  }
}
