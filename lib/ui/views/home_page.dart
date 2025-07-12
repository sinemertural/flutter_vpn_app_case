import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_app_case/data/entity/connection_stats.dart';
import 'package:vpn_app_case/data/entity/country.dart';
import 'package:vpn_app_case/ui/cubit/base_page_cubit.dart';
import 'package:vpn_app_case/ui/cubit/home_page_cubit.dart';
import 'package:vpn_app_case/ui/widgets/country_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Country? expandedCountry;

  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().loadFreeCountries();
  }

  @override
  Widget build(BuildContext context) {
    final freeCountries = context.watch<HomePageCubit>().freeCountries;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text("Home", style: TextStyle(fontSize: 28),),
      ),
      body: BlocBuilder<HomePageCubit, ConnectionStats>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                TextField(
                  readOnly: true,
                  onTap: () {
                    context.read<BasePageCubit>().changPage(1);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: theme.cardColor,
                    hintText: "Search Country",
                    hintStyle: TextStyle(color: theme.hintColor),
                    prefixIcon: Icon(Icons.search, color: theme.hintColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: theme.hintColor, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                if (state.connectedCountry == null)
                  Center(
                    child: Text(
                      "No active connection",
                      style: textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                    ),
                  )
                else
                  Card(
                    color: theme.cardColor,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(state.connectedCountry!.flag, width: 40, height: 30),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.connectedCountry!.name,
                                    style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    state.connectedCountry!.city.isNotEmpty
                                        ? state.connectedCountry!.city
                                        : 'Unknown',
                                    style: textTheme.bodySmall?.copyWith(color: theme.hintColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    barrierColor: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.black.withOpacity(0.6)
                                        : Colors.white.withOpacity(0.6),
                                    builder: (context) {
                                      return Center(
                                        child: SizedBox(
                                          width: 200,
                                          height: 200,
                                          child: Lottie.asset('assets/animations/Disconnect.json'),
                                        ),
                                      );
                                    },
                                  );

                                  context.read<HomePageCubit>().disconnect();
                                  await Future.delayed(const Duration(seconds: 2));
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.error,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                                ),
                                child: Text(
                                  "DISCONNECT",
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onError,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              "Connected",
                              style: textTheme.titleLarge?.copyWith(color: Colors.green),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              "${state.connectedTime.inHours.toString().padLeft(2, '0')}"
                                  ":${(state.connectedTime.inMinutes % 60).toString().padLeft(2, '0')}"
                                  ":${(state.connectedTime.inSeconds % 60).toString().padLeft(2, '0')}",
                              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text("Download", style: textTheme.bodySmall?.copyWith(color: theme.hintColor)),
                                    Text("${state.downloadSpeed} MB",
                                        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Container(height: 40, width: 1, color: theme.dividerColor),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text("Upload", style: textTheme.bodySmall?.copyWith(color: theme.hintColor)),
                                    Text("${state.uploadSpeed} MB",
                                        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Container(height: 40, width: 1, color: theme.dividerColor),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text("Signal", style: textTheme.bodySmall?.copyWith(color: theme.hintColor)),
                                    Text("${state.connectedCountry!.strength}%",
                                        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 24),
                Text(
                  "Free Countries",
                  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                ...freeCountries.map((country) {
                  bool isExpanded = expandedCountry == country;

                  return CountryCard(
                    country: country,
                    isExpanded: isExpanded,
                    onTap: () {
                      setState(() {
                        expandedCountry = isExpanded ? null : country;
                      });
                    },
                    onConnectPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        barrierColor: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black.withOpacity(0.6)
                            : Colors.white.withOpacity(0.6),
                        builder: (context) {
                          return Center(
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Lottie.asset('assets/animations/connecting_animation.json'),
                            ),
                          );
                        },
                      );


                      await Future.delayed(const Duration(seconds: 2));
                      context.read<HomePageCubit>().connect(country);
                      Navigator.of(context).pop();
                      setState(() {
                        expandedCountry = null;
                      });
                    },
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
