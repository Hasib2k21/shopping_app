import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingCard extends StatelessWidget {
  final double screenHeight, screenWidth;
  final Orientation orientation;
  final int index;
  final Function increaseQuantity;
  final Function decreaseQuantity;

  const ShoppingCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.orientation,
    required this.index,
    required this.increaseQuantity,
    required this.decreaseQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      height: (orientation == Orientation.portrait)
          ? screenHeight * 0.15
          : screenHeight * 0.4,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.00),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurStyle: BlurStyle.normal,
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.34,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.00),
                  bottomLeft: Radius.circular(10.00)),
              color: const Color(0xFFE3E3E3),
              image: DecorationImage(
                  image: AssetImage(contents[index].dressImage),
                  fit: BoxFit.fill),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(11.00),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShoppingCardLabels.getDressLabel(
                        text: contents[index].dressName,
                        isLabel: false,
                      ),
                      const Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Wrap(
                      children: [
                        Wrap(
                          children: [
                            ShoppingCardLabels.getDressLabel(
                              text: "Color",
                              isLabel: true,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ShoppingCardLabels.getDressLabel(
                              text: contents[index].dressColor,
                              isLabel: false,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            ShoppingCardLabels.getDressLabel(
                              text: "Size:",
                              isLabel: true,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ShoppingCardLabels.getDressLabel(
                              text: contents[index].dressSize,
                              isLabel: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: (orientation == Orientation.portrait)
                        ? MediaQuery.of(context).size.height * 0.05
                        : MediaQuery.of(context).size.height * 0.16,
                    child: Row(
                      children: [
                        ShoppingCardQuantityButton(
                          icon: Icons.remove,
                          onPressed: decreaseQuantity,
                        ),
                        const SizedBox(width: 15,),
                        Text(
                          contents[index].quantity.toString(),
                          style: GoogleFonts.getFont(
                            'Roboto Condensed',
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: const Color(0xFF222222),
                          ),
                        ),
                        const SizedBox(width: 15,),
                        ShoppingCardQuantityButton(
                          icon: Icons.add,
                          onPressed: increaseQuantity,
                        ),
                        const SizedBox(width: 20,),
                        Text(
                          "${contents[index].dressPrice * contents[index].quantity}\$",
                          style: GoogleFonts.getFont(
                            'Roboto Condensed',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: const Color(0xFF222222),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class CardInfo{
  final String dressName, dressColor, dressSize, dressImage;
  int dressPrice, quantity;

  CardInfo({
    required this.dressName,
    required this.dressColor,
    required this.dressSize,
    required this.dressPrice,
    required this.dressImage,
    required this.quantity,
  });
}

List<CardInfo> contents = [
  CardInfo(
    dressName: "Pullover",
    dressColor: "Black",
    dressSize: "L",
    dressPrice: 51,
    dressImage: "assets/images/image_2.png",
    quantity: 1,
  ),
  CardInfo(
    dressName: "T-Shirt",
    dressColor: "Grey",
    dressSize: "L",
    dressPrice: 30,
    dressImage: "assets/images/image_1.png",
    quantity: 1,
  ),
  CardInfo(
    dressName: "Sport Dress",
    dressColor: "Black",
    dressSize: "M",
    dressPrice: 43,
    dressImage: "assets/images/image.png",
    quantity: 1,
  ),
];
class ShoppingCardLabels {
  static Text getDressLabel({required String text, required bool isLabel}) {
    return Text(
      text,
      style: GoogleFonts.getFont(
        'Roboto Condensed',
        fontSize: 14,
        color: isLabel ? Colors.grey : Colors.black,
      ),
    );
  }
}

class ShoppingCardQuantityButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  const ShoppingCardQuantityButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurStyle: BlurStyle.normal,
            blurRadius: 15,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () => onPressed(),
        icon: Icon(
          icon,
          color: Colors.grey,
          size: 26,
        ),
      ),
    );
  }
}

