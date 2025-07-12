import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_app_case/core/theme/app_theme.dart';
import 'package:vpn_app_case/data/repository/mock_vpn_repository.dart';
import 'package:vpn_app_case/ui/cubit/base_page_cubit.dart';
import 'package:vpn_app_case/ui/cubit/connection_selection_page_cubit.dart';
import 'package:vpn_app_case/ui/cubit/home_page_cubit.dart';
import 'package:vpn_app_case/ui/views/base_page.dart';
import 'package:vpn_app_case/ui/views/country_selection_page.dart';
import 'package:vpn_app_case/ui/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnectionStatsPageCubit(MockVpnRepository()),
          child: const BasePage(),
        ),
        BlocProvider(create: (context) => BasePageCubit()),
        BlocProvider(
          create: (_) => HomePageCubit(MockVpnRepository())..loadFreeCountries(),
        ),
      ],
      child: MaterialApp(
        title: 'VPN App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const BasePage(),
      ),
    );
  }
}

