import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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

  bool isSearching = true;
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
        title: isSearching
            ? TextField(
          autofocus: true,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
          decoration: const InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(
              color: AppColors.textWhite,
              fontSize: 28,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (searchQuery) {
            context.read<ConnectionStatsPageCubit>().filterCountries(searchQuery);
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
          isSearching
              ? IconButton(
            onPressed: () {
              setState(() {
                isSearching = false;
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
                isSearching = true;
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
                      if (country.isFree == true) {
                        setState(() {
                          expandedCountry = isExpanded ? null : country;
                        });
                      } else {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.lock, size: 48, color: Colors.amber),
                                SizedBox(height: 16),
                                Text(
                                  "Premium Server",
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Upgrade to Premium for ultra-fast secure connections.",
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryBlue,
                                  ),
                                  child: Text("Upgrade Now",
                                  style: TextStyle(
                                    color: AppColors.textWhite
                                  ),),
                                )
                              ],
                            ),
                          ),
                        );
                      }
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
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: country.isFree == true ? Colors.green : Colors.amber,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (country.isFree == false) ...[
                                        Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(width: 4),
                                      ],
                                      Text(
                                        country.isFree == true ? "FREE" : "PREMIUM",
                                        style: TextStyle(
                                          color: country.isFree == true ? Colors.green : Colors.amber,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                                const SizedBox(width: 8),

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
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        barrierColor: Theme.of(context).brightness == Brightness.dark
                                           ? Colors.black54
                                            : Colors.white.withOpacity(0.8),
                                        builder: (context) {
                                          return Center(
                                            child: Container(
                                              width: 200,
                                              height: 200,
                                              child: Lottie.asset(
                                                'assets/animations/connecting_animation.json',),
                                            ),
                                          );
                                        },
                                      );
                                      await Future.delayed(const Duration(seconds: 2));

                                      context.read<HomePageCubit>().connect(country);

                                      Navigator.of(context).pop();

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
