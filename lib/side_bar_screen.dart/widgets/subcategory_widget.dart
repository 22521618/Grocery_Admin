import 'package:flutter/material.dart';
import 'package:grocery_web/controllers/subcategory_controller.dart';
import 'package:grocery_web/models/subcategory.dart';

class SubcategoryWidget extends StatefulWidget {
  const SubcategoryWidget({super.key});

  @override
  State<SubcategoryWidget> createState() => _SubcategoryWidgetState();
}

class _SubcategoryWidgetState extends State<SubcategoryWidget> {
  late Future<List<Subcategory>> futureSubcategories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureSubcategories = SubcategoryController().loadSubategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureSubcategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          ); // Center
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No Subcategory'),
          ); // Center
        } else {
          final subcategories = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: subcategories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ), // SliverGridDelegateWithFixedCrossAxisCount
            itemBuilder: (context, index) {
              final subcategory = subcategories[index];
              return Column(children: [
                Image.network(
                  subcategory.image,
                  height: 100,
                  width: 100,
                ),
                Text(subcategory.subCategoryName),
              ]);
            }, // GridView.builder
          );
        }
      }, // FutureBuilder
    );
  }
}
