import 'package:flutter/material.dart';
import 'package:grocery_web/controllers/category_controller.dart';
import 'package:grocery_web/models/categpry.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          ); // Center
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No Category'),
          ); // Center
        } else {
          final categories = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ), // SliverGridDelegateWithFixedCrossAxisCount
            itemBuilder: (context, index) {
              final category = categories[index];
              return Column(children: [
                Image.network(
                  category.image,
                  height: 100,
                  width: 100,
                ),
                Text(category.name),
              ]);
            }, // GridView.builder
          );
        }
      }, // FutureBuilder
    );
  }
}
