import 'package:ecomerce_market/constant.dart';
import 'package:ecomerce_market/core/widgets/search_text_field.dart';
import 'package:ecomerce_market/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: kTopPaddding),
                CustomHomeAppBar(),
                SizedBox(height: 16),
                SearchTextField(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
