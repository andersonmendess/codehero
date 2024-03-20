import 'package:code_hero/constants.dart';
import 'package:code_hero/enums/page_state_enum.dart';
import 'package:code_hero/pages/details/details_page.dart';
import 'package:code_hero/pages/home/components/header_component.dart';
import 'package:code_hero/pages/home/components/pagination_bar_component.dart';
import 'package:code_hero/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<HomeController>().loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Header(),
            Expanded(
              child: Builder(builder: (context) {
                final pageState = context.watch<HomeController>().pageState;

                if (pageState == PageState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (pageState == PageState.error) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Erro ao carregar os personagens'),
                        TextButton(
                          onPressed: () {
                            context.read<HomeController>().loadCharacters();
                          },
                          child: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  );
                }

                return PageView(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 44,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: kPrimaryColor,
                          ),
                          child: const Center(
                            child: Text(
                              'Nome',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                              color: kPrimaryColor,
                              height: 4,
                            ),
                            padding: const EdgeInsets.all(16),
                            itemCount: context
                                .watch<HomeController>()
                                .characters
                                .length,
                            itemBuilder: (context, index) {
                              final character = context
                                  .read<HomeController>()
                                  .characters[index];

                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsPage(character: character),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              character.imageUrl,
                                            ),
                                            radius: 35,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Flexible(
                                          flex: 2,
                                          child: Text(
                                            character.name,
                                            style: const TextStyle(
                                              color: kGreyTextColor,
                                              fontSize: 21,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 44,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: kPrimaryColor,
                          ),
                          child: const Center(
                            child: Text(
                              'Séries',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                              color: kPrimaryColor,
                              height: 4,
                            ),
                            padding: const EdgeInsets.all(16),
                            itemCount: context
                                .watch<HomeController>()
                                .characters
                                .length,
                            itemBuilder: (context, index) {
                              final character = context
                                  .read<HomeController>()
                                  .characters[index];

                              return SizedBox(
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      const SizedBox(width: 16),
                                      Flexible(
                                        child: Text(
                                          character.series
                                              .map((e) => e.name)
                                              .join(', '),
                                          style: const TextStyle(
                                            color: kGreyTextColor,
                                            fontSize: 21,
                                          ),
                                          maxLines: 3,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 44,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: kPrimaryColor,
                          ),
                          child: const Center(
                            child: Text(
                              'Eventos',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                              color: kPrimaryColor,
                              height: 4,
                            ),
                            padding: const EdgeInsets.all(16),
                            itemCount: context
                                .watch<HomeController>()
                                .characters
                                .length,
                            itemBuilder: (context, index) {
                              final character = context
                                  .read<HomeController>()
                                  .characters[index];

                              return SizedBox(
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      const SizedBox(width: 16),
                                      Flexible(
                                        child: Text(
                                          character.events
                                              .map((e) => e.name)
                                              .join(', '),
                                          style: const TextStyle(
                                            color: kGreyTextColor,
                                            fontSize: 21,
                                          ),
                                          maxLines: 3,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }),
            ),
            const PaginationBar(),
            Container(
              height: 15,
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
