
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/shopcard.dart';

import 'alert.dart';
import 'checkout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        appBarTheme: Appbar.getAppbarStyle(),
        elevatedButtonTheme: ElevatedButtonStyle.getElevatedButtonStyle(),
      ),
    );
  }
}
class Appbar {
  static AppBarTheme getAppbarStyle() => const AppBarTheme(
    backgroundColor: Color(0xFFF9F9F9),
    iconTheme: IconThemeData(
      size: 28,
    ),
  );
}
class ElevatedButtonStyle {
  static ElevatedButtonThemeData getElevatedButtonStyle() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDB3022),
          elevation: 5,
          shadowColor: Colors.red,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.getFont(
            'Roboto Condensed',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      );
}
class HomeScreen extends StatefulWidget {
  final double screenHeight, screenWidth;
  const HomeScreen({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  late int totalPrice;
  @override
  void initState() {
    totalPrice = calculateTotalPrice();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return Container(
            margin: const EdgeInsets.all(15.00),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                      "My Bag",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: (orientation == Orientation.portrait) ? 25 : 16,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: contents.length,
                    itemBuilder: (context, index) => ShoppingCard(
                      screenHeight: widget.screenHeight,
                      screenWidth: widget.screenWidth,
                      orientation: orientation,
                      index: index,
                      increaseQuantity: () {
                        increaseQuantity(index, orientation);
                        setState(() {});
                      },
                      decreaseQuantity: () {
                        decreaseQuantity(index);
                        setState(() {});
                      },
                    ),
                  ),
                ),
                CheckOutForm(
                  orientation: orientation,
                  screenHeight: widget.screenHeight,
                  screenWidth: widget.screenWidth,
                  totalPrice: totalPrice,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(showSnackBar());
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  int calculateTotalPrice() {
    int totalPrice = 0;
    for (CardInfo data in contents) {
      totalPrice += data.dressPrice;
    }
    return totalPrice;
  }

  void increaseQuantity(int index, Orientation orientation) {
    if (contents[index].quantity < 5) {
      contents[index].quantity += 1;
      totalPrice += contents[index].dressPrice;
    }
    if (contents[index].quantity == 5) {
      showAlertDialog(index, orientation);
    }
  }

  void showAlertDialog(int index, Orientation orientation) {
    showDialog(
      context: context,
      builder: (context) {
        return AppAlertDialog(
          title: "Congratulations!",
          content: "You have added\n5\n${contents[index].dressName.toString()} in your bag!",
          orientation: orientation,
        );
      },
    );
  }


  void decreaseQuantity(int index) {
    if (contents[index].quantity > 1) {
      contents[index].quantity -= 1;
      totalPrice -= contents[index].dressPrice;
    }
  }

  SnackBar showSnackBar() {
    return SnackBar(
      content: const Text(
        "Congratulations! Your purchase was a success!!",
        style: TextStyle(
          fontSize: 15,
          fontFamily: "Inter",
        ),

      ),
      padding: const EdgeInsets.all(20.00),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green[600],
      elevation: 10,
    );
  }
}



