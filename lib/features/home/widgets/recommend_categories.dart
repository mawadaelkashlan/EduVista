import 'package:flutter/material.dart';

class RecommendedCategoriesWidget extends StatelessWidget {
  final Future<List<String>> future;

  const RecommendedCategoriesWidget({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No categories available.'));
        }
        var categories = snapshot.data!;
        return SizedBox(
          height: 40,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                height: 20,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xffE0E0E0),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(categories[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
