import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grocery_web/controllers/vendor_controller.dart';

import 'package:grocery_web/models/vendor.dart';

class VendorWidget extends StatefulWidget {
  const VendorWidget({super.key});

  @override
  State<VendorWidget> createState() => _VendorWidgetState();
}

class _VendorWidgetState extends State<VendorWidget> {
  late Future<List<Vendor>> futureVendors;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureVendors = VendorController().loadVendors();
  }

  @override
  Widget build(BuildContext context) {
    Widget vendorData(int flex, Widget widget) {
      return Expanded(
        flex: flex,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: widget, // Text
          ), // Padding
        ),
      );
    }

    return FutureBuilder(
      future: futureVendors,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          ); // Center
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No Banners'),
          ); // Center
        } else {
          final vendors = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: vendors.length,

            itemBuilder: (context, index) {
              final vendor = vendors[index];
              return Row(
                children: [
                  vendorData(
                    1,
                    CircleAvatar(
                      child: Text(
                        vendor.fullName[0],
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  vendorData(
                    3,
                    Text(
                      vendor.fullName,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  vendorData(
                    2,
                    Text(
                      vendor.email,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  vendorData(
                    2,
                    Text(
                      "${vendor.state} ${vendor.city}",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  vendorData(
                    1,
                    TextButton(
                      onPressed: () {},
                      child: Text("Delete"),
                    ),
                  ),
                ],
              );
            }, // GridView.builder
          );
        }
      }, // FutureBuilder
    );
  }
}
