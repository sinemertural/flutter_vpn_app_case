import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_app_case/core/theme/app_colors.dart';
import 'package:vpn_app_case/data/entity/connection_stats.dart';
import 'package:vpn_app_case/data/entity/country.dart';
import 'package:vpn_app_case/data/repository/mock_vpn_repository.dart';
import 'package:vpn_app_case/ui/cubit/base_page_cubit.dart';
import 'package:vpn_app_case/ui/cubit/home_page_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Country? expandedCountry;
  List<Country> freeCountries = [];

  @override
  void initState() {
    super.initState();
    _loadFreeCountries();
  }

  Future<void> _loadFreeCountries() async {
    var countries = await MockVpnRepository().getCountries();
    setState(() {
      freeCountries = countries.where((c) => c.isFree == true).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: const Text(
          "Home",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite,
          ),
        ),
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
                    fillColor: AppColors.textWhite,
                    hintText: "Search Country",
                    prefixIcon: const Icon(Icons.search, color: AppColors.textGray),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.textGray, width: 1.5),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                if (state.connectedCountry == null)
                  const Center(
                    child: Text(
                      "No active connection",
                      style: TextStyle(fontSize: 18, color: AppColors.textGray),
                    ),
                  )
                else
                  Card(
                    color: AppColors.textWhite,
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
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    state.connectedCountry!.city.isNotEmpty
                                        ? state.connectedCountry!.city
                                        : 'Unknown',
                                    style: const TextStyle(fontSize: 16, color: AppColors.textGray),
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
                                  backgroundColor: AppColors.textDark,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                                ),
                                child: const Text(
                                  "DISCONNECT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textWhite,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Center(
                            child: Text(
                              "Connected",
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700, fontSize: 25),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              "${state.connectedTime.inHours.toString().padLeft(2, '0')}"
                                  ":${(state.connectedTime.inMinutes % 60).toString().padLeft(2, '0')}"
                                  ":${(state.connectedTime.inSeconds % 60).toString().padLeft(2, '0')}",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text("Download", style: TextStyle(color: AppColors.textGray)),
                                    Text("${state.downloadSpeed} MB",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: AppColors.textDark)),
                                  ],
                                ),
                              ),
                              Container(height: 40, width: 1, color: Colors.grey.shade300),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text("Upload", style: TextStyle(color: AppColors.textGray)),
                                    Text("${state.uploadSpeed} MB",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: AppColors.textDark)),
                                  ],
                                ),
                              ),
                              Container(height: 40, width: 1, color: Colors.grey.shade300),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text("Signal", style: TextStyle(color: AppColors.textGray)),
                                    Text("${state.connectedCountry!.strength}%",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: AppColors.textDark)),
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
                const Text(
                  "Free Countries",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),

                const SizedBox(height: 8),

                ...freeCountries.map((country) {
                  bool isExpanded = expandedCountry == country;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        expandedCountry = isExpanded ? null : country;
                      });
                    },
                    child: Card(
                      color: AppColors.textWhite,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(country.flag, width: 40, height: 30),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(country.name,
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                      Text("${country.locationCount} locations",
                                          style: const TextStyle(color: AppColors.textGray)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green, width: 1.5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text("FREE",
                                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 8),
                                Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                    color: AppColors.textDark),
                              ],
                            ),
                            if (isExpanded) ...[
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return Center(
                                            child: SizedBox(
                                              width: 200,
                                              height: 200,
                                              child: Lottie.asset(
                                                  'assets/animations/connecting_animation.json'),
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
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryBlue,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    child: const Text(
                                      "Connect",
                                      style: TextStyle(color: AppColors.textWhite, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
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
