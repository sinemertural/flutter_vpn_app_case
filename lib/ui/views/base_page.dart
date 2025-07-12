import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_app_case/ui/cubit/base_page_cubit.dart';
import 'package:vpn_app_case/ui/views/country_selection_page.dart';
import 'package:vpn_app_case/ui/views/home_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<BasePageCubit, int>(
      builder: (context, selectedPage) {
        final pages = [const HomePage(), const CountrySelectionPage()];

        return Scaffold(
          body: pages[selectedPage],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
                Theme.of(context).colorScheme.surface,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.public_outlined),
                activeIcon: Icon(Icons.public),
                label: "Countries",
              ),
            ],
            currentIndex: selectedPage,
            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: theme.hintColor,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
            onTap: (index) {
              context.read<BasePageCubit>().changPage(index);
            },
          ),
        );
      },
    );
  }
}
