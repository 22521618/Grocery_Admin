import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_web/controllers/buyer_cotnroller.dart';
import 'package:grocery_web/models/buyer.dart';

class BuyerWidget extends StatefulWidget {
  const BuyerWidget({super.key});

  @override
  State<BuyerWidget> createState() => _BuyerWidgetState();
}

class _BuyerWidgetState extends State<BuyerWidget> {
  late Future<List<Buyer>> futureBuyers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureBuyers = BuyerCotnroller().loadBuyers();
  }

  @override
  Widget build(BuildContext context) {
    Widget buyerData(int flex, Widget widget) {
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
      future: futureBuyers,
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
          final buyers = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: buyers.length,

            itemBuilder: (context, index) {
              final buyer = buyers[index];
              return Row(
                children: [
                  buyerData(
                    1,
                    CircleAvatar(
                      child: Text(
                        buyer.fullName[0],
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  buyerData(
                    3,
                    Text(
                      buyer.fullName,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buyerData(
                    2,
                    Text(
                      buyer.email,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buyerData(
                    2,
                    Text(
                      "${buyer.state} ${buyer.city}",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buyerData(
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
