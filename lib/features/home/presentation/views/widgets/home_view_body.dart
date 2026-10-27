import 'package:ecomerce_market/constant.dart';
import 'package:ecomerce_market/core/widgets/search_text_field.dart';
import 'package:ecomerce_market/features/home/presentation/views/widgets/best_selling_grid_view.dart';
import 'package:ecomerce_market/features/home/presentation/views/widgets/best_selling_header.dart';
import 'package:ecomerce_market/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:ecomerce_market/features/home/presentation/views/widgets/featured_list.dart';
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
                SizedBox(height: 12),
                FeaturedList(),
                SizedBox(height: 12),
                BestSellingHeader(),
                SizedBox(height: 8),
              ],
            ),
          ),
          BestSellingGridView(),
        ],
      ),
    );
  }
}
