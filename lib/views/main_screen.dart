import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:grocery_web/side_bar_screen.dart/buyers_screen.dart';
import 'package:grocery_web/side_bar_screen.dart/category_screen.dart';
import 'package:grocery_web/side_bar_screen.dart/orders_screen.dart';
import 'package:grocery_web/side_bar_screen.dart/products_screen.dart';
import 'package:grocery_web/side_bar_screen.dart/subcategory_sreen.dart';
import 'package:grocery_web/side_bar_screen.dart/upload_banner_screen.dart';
import 'package:grocery_web/side_bar_screen.dart/vendors_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = const VendorsScreen();

  screenSelector(item) {
    switch (item.route) {
      case BuyersScreen.id:
        setState(() {
          _selectedScreen = const BuyersScreen();
        });
        break;

      case VendorsScreen.id:
        setState(() {
          _selectedScreen = const VendorsScreen();
        });
        break;

      case OrdersScreen.id:
        setState(() {
          _selectedScreen = const OrdersScreen();
        });
        break;

      case CategoryScreen.id:
        setState(() {
          _selectedScreen = const CategoryScreen();
        });
        break;
      case SubcategorySreen.id:
        setState(() {
          _selectedScreen = const SubcategorySreen();
        });
        break;

      case UploadBannerScreen.id:
        setState(() {
          _selectedScreen = const UploadBannerScreen();
        });
        break;

      case ProductsScreen.id:
        setState(() {
          _selectedScreen = const ProductsScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Management"),
      ),
      body: _selectedScreen,
      sideBar: SideBar(
        header: Container(
          height: 50,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: const Center(
            child: Text(
              'Multi Vendor Admin',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.7,
                color: Colors.white,
              ),
            ),
          ),
        ),
        items: const [
          AdminMenuItem(
            title: 'Vendors',
            route: VendorsScreen.id,
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'Buyers',
            route: BuyersScreen.id,
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: OrdersScreen.id,
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'Categories',
            route: CategoryScreen.id,
            icon: Icons.category,
          ),
          AdminMenuItem(
            title: 'Subcategory',
            route: SubcategorySreen.id,
            icon: Icons.category_outlined,
          ),
          AdminMenuItem(
            title: 'Upload Banner',
            route: UploadBannerScreen.id,
            icon: Icons.upload,
          ),
          AdminMenuItem(
            title: 'Products',
            route: ProductsScreen.id,
            icon: Icons.store,
          ),
        ],
        selectedRoute: VendorsScreen.id,
        onSelected: (item) {
          screenSelector(item);
        },
      ),
    );
  }
}
