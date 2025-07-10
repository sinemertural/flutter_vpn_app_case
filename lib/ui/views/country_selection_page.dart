import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_app_case/core/theme/app_colors.dart';
import 'package:vpn_app_case/data/entity/country.dart';
import 'package:vpn_app_case/ui/cubit/base_page_cubit.dart';
import 'package:vpn_app_case/ui/cubit/home_page_cubit.dart';

import '../../core/constants/country_codes.dart';
import '../cubit/connection_stats_page_cubit.dart';

class CountrySelectionPage extends StatefulWidget {
  const CountrySelectionPage({super.key});

  @override
  State<CountrySelectionPage> createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage> {

  bool aramaYapiliyorMu = true;
  Country? expandedCountry;

  @override
  void initState() {
    super.initState();
    context.read<ConnectionStatsPageCubit>().loadCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryBlue,
        title: aramaYapiliyorMu
            ? TextField(
          autofocus: true,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
          decoration: const InputDecoration(
            hintText: "Ara",
            hintStyle: TextStyle(
              color: AppColors.textWhite,
              fontSize: 28,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (aramaSonucu) {
            context.read<ConnectionStatsPageCubit>().filterCountries(aramaSonucu);
          },
        )
            : const Text(
          "Country Selection",
          style: TextStyle(
            fontSize: 28,
            color: AppColors.textWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = false;
              });
              context.read<ConnectionStatsPageCubit>().loadCountries();
            },
            icon: const Icon(Icons.close),
            color: AppColors.textWhite,
            iconSize: 28,
          )
              : IconButton(
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = true;
              });
            },
            icon: const Icon(Icons.search, color: AppColors.textWhite),
            iconSize: 28,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: BlocBuilder<ConnectionStatsPageCubit, List<Country>>(
          builder: (context, countryList) {
            if (countryList.isNotEmpty) {
              return ListView.builder(
                itemCount: countryList.length,
                itemBuilder: (context, index) {
                  var country = countryList[index];
                  String code = countryCodes[country.name] ?? "unknown";
                  bool isExpanded = expandedCountry == country;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isExpanded) {
                          expandedCountry = null; // Kapat
                        } else {
                          expandedCountry = country; // Aç
                        }
                      });
                    },
                    child: Card(
                      color: AppColors.textWhite,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/flags/$code.png",
                                  width: 40,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        country.name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textDark,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${country.locationCount} locations",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.textGray,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                  color: AppColors.textDark,
                                ),
                              ],
                            ),
                            if (isExpanded) ...[
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:[
                                  ElevatedButton(
                                  onPressed: () {
                                    context.read<HomePageCubit>().connect(country);
                                    context.read<BasePageCubit>().changPage(0);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                  ),
                                  child: const Text(
                                    "Connect",
                                    style: TextStyle(
                                      color: AppColors.textWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                ]
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }
}
