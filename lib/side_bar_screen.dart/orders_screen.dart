import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_web/side_bar_screen.dart/widgets/buyer_widget.dart';
import 'package:grocery_web/side_bar_screen.dart/widgets/order_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const String id = 'orderscreen';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _rowHeader(int flex, String text) {
      return Expanded(
        flex: flex,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
            color: const Color(0xFF3C55EF),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ), // Text
          ), // Padding
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Manage Orders',
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                _rowHeader(2, 'Product Image'),
                _rowHeader(3, 'Product Name'),
                _rowHeader(2, 'Product Price'),
                _rowHeader(3, 'Product Category'),
                _rowHeader(3, 'Buyer Name'),
                _rowHeader(2, 'Buyer Email'),
                _rowHeader(2, 'Buyer Address'),
                _rowHeader(1, "Status")
              ],
            ),
            OrderWidget(),
          ],
        ),
      ),
    );
  }
}
