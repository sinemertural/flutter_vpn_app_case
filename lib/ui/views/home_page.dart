import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn_app_case/core/theme/app_colors.dart';
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
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                readOnly: true,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CountrySelectionPage()),
                  );
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
                      width: 1.5
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
            )
          ],
        )
      ),
      );
  }
}
