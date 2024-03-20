import 'package:code_hero/models/character.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class DetailsPage extends StatefulWidget {
  final CharacterModel character;
  const DetailsPage({
    super.key,
    required this.character,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<PaletteGenerator> generatePalette() async {
    try {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(widget.character.imageUrl),
        size: const Size(150, 150),
        region: Offset.zero & const Size(75, 75),
        maximumColorCount: 5,
      );

      return paletteGenerator;
    } catch (e) {
      return PaletteGenerator.fromColors(
        [
          PaletteColor(Colors.white, 2),
          PaletteColor(Colors.red, 2),
          PaletteColor(Colors.red, 2),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: generatePalette(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final paletteGenerator = snapshot.data as PaletteGenerator;

        final textColor = paletteGenerator.dominantColor?.bodyTextColor;
        final bgColor = paletteGenerator.dominantColor?.color;
        final fgColor = Color.alphaBlend(
            Colors.white54, paletteGenerator.vibrantColor?.color ?? Colors.red);

        return Theme(
          data: ThemeData(
            primaryColor: bgColor,
            scaffoldBackgroundColor: bgColor,
            appBarTheme: AppBarTheme(
              backgroundColor: fgColor,
              foregroundColor: textColor,
              elevation: 0,
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          child: Image.network(
                            widget.character.imageUrl,
                            width: 200,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            widget.character.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (widget.character.description != null &&
                        widget.character.description!.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.character.description ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Comics',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.character.comics.length,
                              itemBuilder: (context, index) {
                                final comic = widget.character.comics[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: fgColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              comic.name.split('').first,
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: bgColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          comic.name,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: textColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Series',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.character.series.length,
                              itemBuilder: (context, index) {
                                final serie = widget.character.series[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: fgColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              serie.name.split('').first,
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: bgColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          serie.name,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: textColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ' Stories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                    Card(
                      color: fgColor,
                      margin: const EdgeInsets.all(8),
                      elevation: 0,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...widget.character.stories.map((serie) {
                              return Text(
                                serie.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: bgColor,
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
