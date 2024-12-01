import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:grocery_web/controllers/category_controller.dart';
import 'package:grocery_web/controllers/subcategory_controller.dart';
import 'package:grocery_web/models/categpry.dart';
import 'package:grocery_web/side_bar_screen.dart/widgets/subcategory_widget.dart';

class SubcategorySreen extends StatefulWidget {
  static const String id = 'subcategoryScreen';
  const SubcategorySreen({super.key});

  @override
  State<SubcategorySreen> createState() => _SubcategorySreenState();
}

class _SubcategorySreenState extends State<SubcategorySreen> {
  final SubcategoryController _subcategoryController = SubcategoryController();
  late String name;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<List<Category>> futureCategories;
  Category? selectedCategory;

  dynamic _image;
  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView (
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'SubCategories',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            FutureBuilder(
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
                  return DropdownButton<Category>(
                    value: selectedCategory,
                    hint: const Text('Select Category'),
                    items: snapshot.data!.map((Category category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                      print(selectedCategory!.name);
                    },
                  );
                }
              }, // FutureBuilder
            ),
            Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                  child: Center(
                    child: _image != null
                        ? Image.memory(_image)
                        : Text('SubCategory image'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      onChanged: (value) {
                        name = value;
                      },
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else {
                          return "Please enter Subcategory name";
                        }
                      },
                      decoration:
                          InputDecoration(labelText: 'Enter SubCategory Name'),
                    ),
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _subcategoryController.uploadSubcategory(
                        categoryId: selectedCategory!.id,
                        categoryName: selectedCategory!.name,
                        pickedImage: _image,
                        subcategoryName: name,
                        context: context,
                      );

                      setState(() {
                        _formKey.currentState!.reset();
                        _image = null;
                      });
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ), // ElevatedButton
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: Text(
                  'Pick me',
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            SubcategoryWidget(),
          ],
        ),
      ),
    );
  }
}
