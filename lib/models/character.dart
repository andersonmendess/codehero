class CharacterModel {
  final int id;
  final String name;
  final String? description;
  final String modified;
  final Thumbnail thumbnail;
  final List<Comic> comics;
  final List<Series> series;
  final List<Story> stories;
  final List<Event> events;
  final List<Url> urls;

  CharacterModel({
    required this.id,
    required this.name,
    this.description,
    required this.modified,
    required this.thumbnail,
    required this.comics,
    required this.series,
    required this.stories,
    required this.events,
    required this.urls,
  });

  get imageUrl => '${thumbnail.path}.${thumbnail.extension}';

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      modified: json['modified'],
      thumbnail: Thumbnail.fromJson(json['thumbnail']),
      comics: (json['comics']['items'] as List)
          .map((item) => Comic.fromJson(item))
          .toList(),
      series: (json['series']['items'] as List)
          .map((item) => Series.fromJson(item))
          .toList(),
      stories: (json['stories']['items'] as List)
          .map((item) => Story.fromJson(item))
          .toList(),
      events: (json['events']['items'] as List)
          .map((item) => Event.fromJson(item))
          .toList(),
      urls: (json['urls'] as List).map((item) => Url.fromJson(item)).toList(),
    );
  }
}

class Thumbnail {
  final String path;
  final String extension;

  Thumbnail({
    required this.path,
    required this.extension,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      path: json['path'],
      extension: json['extension'],
    );
  }
}

class Comic {
  final String resourceURI;
  final String name;

  Comic({
    required this.resourceURI,
    required this.name,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      resourceURI: json['resourceURI'],
      name: json['name'],
    );
  }
}

class Series {
  final String resourceURI;
  final String name;

  Series({required this.resourceURI, required this.name});

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      resourceURI: json['resourceURI'],
      name: json['name'],
    );
  }
}

class Story {
  final String resourceURI;
  final String name;
  final String type;

  Story({
    required this.resourceURI,
    required this.name,
    required this.type,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      resourceURI: json['resourceURI'],
      name: json['name'],
      type: json['type'],
    );
  }
}

class Event {
  final String resourceURI;
  final String name;

  Event({
    required this.resourceURI,
    required this.name,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      resourceURI: json['resourceURI'],
      name: json['name'],
    );
  }
}

class Url {
  final String type;
  final String url;

  Url({required this.type, required this.url});

  factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      type: json['type'],
      url: json['url'],
    );
  }
}
