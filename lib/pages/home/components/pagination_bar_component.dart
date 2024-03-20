import 'dart:math';

import 'package:code_hero/constants.dart';
import 'package:code_hero/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginationBar extends StatelessWidget {
  const PaginationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPage = context.watch<HomeController>().currentPage;
    final limit = context.watch<HomeController>().limit;
    final count = context.watch<HomeController>().count;

    final canPrev = currentPage > 1;
    final canNext = currentPage < count / limit;
    final maxPage = count ~/ limit;

    if (maxPage == 0) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 42, top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor.withOpacity(canPrev ? 1 : 0.3),
            ),
            onPressed: () {
              if (canPrev) context.read<HomeController>().previousPage();
            },
          ),
          PageButton(
            current: currentPage,
            maxPage: maxPage,
            onTap: (page) {
              context.read<HomeController>().setPage(page);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: kPrimaryColor.withOpacity(
                canNext ? 1 : 0.3,
              ),
            ),
            onPressed: () {
              if (canNext) context.read<HomeController>().nextPage();
            },
          ),
        ],
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  final int current;
  final int maxPage;
  final Function(int) onTap;
  const PageButton({
    super.key,
    required this.current,
    required this.maxPage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isStart = current == 1;
    final isEnd = current == maxPage;

    return Row(
      children: [
        ...List.generate(min(3, maxPage), (index) {
          return GestureDetector(
            onTap: () {
              onTap(index == 0
                  ? current - 1
                  : index == 1
                      ? current
                      : current + 1);
            },
            child: Builder(builder: (context) {
              if (isStart && index == 0) return const SizedBox();
              if (isEnd && index == 2) return const SizedBox();

              return Container(
                margin: const EdgeInsets.only(right: 8),
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: index == 1 ? kPrimaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: kPrimaryColor,
                  ),
                ),
                child: Center(
                  child: Text(
                    index == 0
                        ? isStart
                            ? ''
                            : '${current - 1}'
                        : index == 1
                            ? '$current'
                            : isEnd
                                ? ''
                                : '${current + 1}',
                    style: TextStyle(
                      color:
                          index == 1 ? Colors.white : const Color(0xFFD42026),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ],
    );
  }
}
