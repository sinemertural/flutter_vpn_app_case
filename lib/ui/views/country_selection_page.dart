import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_app_case/data/entity/country.dart';
import 'package:vpn_app_case/ui/cubit/base_page_cubit.dart';
import 'package:vpn_app_case/ui/cubit/home_page_cubit.dart';
import 'package:vpn_app_case/ui/widgets/country_card.dart';
import '../cubit/connection_selection_page_cubit.dart';

class CountrySelectionPage extends StatefulWidget {
  const CountrySelectionPage({super.key});

  @override
  State<CountrySelectionPage> createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage> {
  bool isSearching = true;
  Country? expandedCountry;

  @override
  void initState() {
    super.initState();
    context.read<ConnectionStatsPageCubit>().loadCountries();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.appBarTheme.foregroundColor ?? Colors.white;
    final connectedCountry = context.watch<HomePageCubit>().state.connectedCountry;


    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        title: isSearching
            ? TextField(
          autofocus: true,
          style: TextStyle(
            color: textColor,
            fontSize: 28,
          ),
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(
              color: textColor.withOpacity(0.5),
              fontSize: 28,
            ),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
          ),
          onChanged: (searchQuery) {
            context.read<ConnectionStatsPageCubit>().filterCountries(searchQuery);
          },
        )
            : Text("Country Selection",
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() => isSearching = !isSearching);
              context.read<ConnectionStatsPageCubit>().loadCountries();
            },
            icon: Icon(isSearching ? Icons.close : Icons.search, color: textColor),
            iconSize: 28,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: BlocBuilder<ConnectionStatsPageCubit, List<Country>>(
          builder: (context, countryList) {
            if (countryList.isEmpty) return const Center(child: CircularProgressIndicator());

            return ListView.builder(
              itemCount: countryList.length,
              itemBuilder: (context, index) {
                final country = countryList[index];
                final isExpanded = expandedCountry == country;


                return CountryCard(
                  country: country,
                  isExpanded: isExpanded,
                  isConnected: connectedCountry?.name == country.name,
                  onTap: () {
                    if (country.isFree) {
                      setState(() => expandedCountry = isExpanded ? null : country);
                    } else {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        backgroundColor: theme.cardColor,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 64,
                                height: 64,
                                child: Lottie.asset(
                                  'assets/animations/locked_animation.json',
                                  repeat: false,
                                  animate: false,
                                  fit: BoxFit.contain,
                                ),
                              ),

                              const SizedBox(height: 16),
                              Text(
                                "Premium Server",
                                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Upgrade to Premium for ultra-fast secure connections.",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                ),
                                child: Text("Upgrade Now", style: TextStyle(color: textColor)),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  onConnectPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.6)
                          : Colors.white.withOpacity(0.6),
                      builder: (context) => Center(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset('assets/animations/connecting_animation.json'),
                        ),
                      ),
                    );

                    await Future.delayed(const Duration(seconds: 2));
                    context.read<HomePageCubit>().connect(country);
                    Navigator.of(context).pop();
                    context.read<BasePageCubit>().changPage(0);
                  },
                  onDisconnectPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.6)
                          : Colors.white.withOpacity(0.6),
                      builder: (context) => Center(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset('assets/animations/Disconnect.json'),
                        ),
                      ),
                    );

                    context.read<HomePageCubit>().disconnect();
                    await Future.delayed(const Duration(seconds: 2));
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
