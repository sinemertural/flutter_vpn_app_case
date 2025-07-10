import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vpn_app_case/core/theme/app_colors.dart';
import 'package:vpn_app_case/data/entity/connection_stats.dart';
import 'package:vpn_app_case/ui/cubit/base_page_cubit.dart';
import 'package:vpn_app_case/ui/cubit/home_page_cubit.dart';
import 'package:vpn_app_case/ui/views/country_selection_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: Text("Home", style: TextStyle(
            fontSize: 28 ,
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite
        ),
        ),
      ),
      body: BlocBuilder<HomePageCubit, ConnectionStats>(
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    readOnly: true,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      context.read<BasePageCubit>().changPage(1);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textWhite,
                      hintText: "Search Country",
                      hintStyle: const TextStyle(color: AppColors.textGray),
                      prefixIcon: const Icon(Icons.search, color: AppColors.textGray),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.textGray,
                          width: 1.5,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),

                  // Eğer bağlı ülke yoksa:
                  if (state.connectedCountry == null)
                    const Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: Text("No active connection",
                        style: TextStyle(fontSize: 18, color: AppColors.textGray),
                      ),
                    )
                  else
                    Card(
                      color: AppColors.textWhite,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  state.connectedCountry!.flag,
                                  width: 40,
                                  height: 30,
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.connectedCountry!.name,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      state.connectedCountry!.city.isNotEmpty
                                          ? state.connectedCountry!.city
                                          : 'Unknown',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.textGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(onPressed: (){
                                  context.read<HomePageCubit>().disconnect();
                                },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.textDark,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 50 , vertical: 10)
                                  ),
                                  child: Text("DISCONNECT",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.textWhite,
                                        fontSize: 20
                                      )
                                      ,),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            
                            Center(
                              child: Text("Connected" ,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25
                                )
                              ),
                            ),

                            SizedBox( height: 8,),

                            Center(
                              child: Text(
                                "${state.connectedTime.inHours.toString().padLeft(2, '0')}"
                                    ":${(state.connectedTime.inMinutes % 60).toString().padLeft(2, '0')}"
                                    ":${(state.connectedTime.inSeconds % 60).toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),


                            SizedBox( height: 8,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Download",
                                        style: TextStyle(
                                          color: AppColors.textGray,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${state.downloadSpeed} MB",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: AppColors.textDark,
                                        ),
                                      ),
                                    ],),
                                ),
                                Container(
                                  height: 40,
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Upload",
                                        style: TextStyle(
                                          color: AppColors.textGray,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${state.uploadSpeed} MB",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: AppColors.textDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Signal",
                                        style: TextStyle(
                                          color: AppColors.textGray,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${state.connectedCountry!.strength}%",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: AppColors.textDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
