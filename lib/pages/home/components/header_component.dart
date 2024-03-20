import 'package:code_hero/constants.dart';
import 'package:code_hero/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  final TextEditingController inputTecontroller;
  Header({super.key}) : inputTecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 42, top: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              text: 'BUSCA MARVEL ',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'TESTE FRONT-END',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 54,
            height: 7,
            child: Divider(
              color: kPrimaryColor,
              thickness: 2.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Nome do Personagem",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 16,
            ),
          ),
          TextFormField(
            style: const TextStyle(
              color: kPrimaryColor,
              height: 0.8,
            ),
            controller: inputTecontroller,
            onFieldSubmitted: (value) {
              context.read<HomeController>().searchCharacters(value);
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<HomeController>().refreshCharacters();
                  inputTecontroller.clear();
                },
                icon: const Icon(
                  Icons.clear,
                  color: kPrimaryColor,
                ),
              ),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: kPrimaryColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: kPrimaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
