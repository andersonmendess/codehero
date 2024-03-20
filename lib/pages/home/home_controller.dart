import 'package:code_hero/enums/page_state_enum.dart';
import 'package:code_hero/models/character.dart';
import 'package:code_hero/repositories/characters_repository.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final repository = CharactersRepository();

  List<CharacterModel> characters = [];

  PageState pageState = PageState.loading;

  int currentPage = 1;
  int limit = 4;
  int count = 0;
  String? nameStartsWith;

  Future<void> loadCharacters() async {
    setPageState(PageState.loading);

    repository
        .getCharacters(
      limit: limit,
      offset: (currentPage - 1) * limit,
      nameStartsWith: nameStartsWith,
    )
        .then((value) {
      setCharacters(value.results);
      count = value.total;

      setPageState(PageState.idle);
    }).catchError((err) {
      setPageState(PageState.error);
    });
  }

  Future<void> refreshCharacters() async {
    currentPage = 1;
    characters = [];
    nameStartsWith = null;
    loadCharacters();
  }

  Future<void> searchCharacters(String name) async {
    nameStartsWith = name;
    currentPage = 1;
    loadCharacters();
  }

  Future<void> nextPage() async {
    if (currentPage < count / limit) {
      currentPage++;
      loadCharacters();
    }
  }

  Future<void> previousPage() async {
    if (currentPage > 1) {
      currentPage--;
      loadCharacters();
    }
  }

  Future<void> setPage(int page) async {
    currentPage = page;
    loadCharacters();
  }

  void setCharacters(List<CharacterModel> characters) {
    this.characters = characters;
    notifyListeners();
  }

  void setPageState(PageState ps) {
    if (pageState == ps) return;
    pageState = ps;
    notifyListeners();
  }
}
