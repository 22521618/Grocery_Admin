import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_web/side_bar_screen.dart/widgets/buyer_widget.dart';
import 'package:grocery_web/side_bar_screen.dart/widgets/vendor_widget.dart';

class VendorsScreen extends StatelessWidget {
  static const String id = '\vendorScreen';
  const VendorsScreen({super.key});

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
                'Manage Vendors',
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
                _rowHeader(1, 'Image'),
                _rowHeader(3, 'Full Name'),
                _rowHeader(2, 'Email'),
                _rowHeader(2, 'Address'),
                _rowHeader(1, "Delete"),
              ],
            ),
            VendorWidget(), // Row
          ],
        ),
      ),
    );
  }
}
