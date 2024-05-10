import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppAlertDialog extends StatelessWidget {
  final String title, content;
  final Orientation orientation;

  const AppAlertDialog(
      {super.key,
        required this.title,
        required this.content,
        required this.orientation});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: Center(
        child: Text(
          title,
          style: GoogleFonts.getFont(
              'Roboto Condensed',
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: GoogleFonts.getFont(
          'Roboto Condensed',
          fontSize: 18,
        ),
      ),
      contentPadding: const EdgeInsets.all(40.00),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: (orientation == Orientation.portrait)
              ? MediaQuery.of(context).size.height * 0.06
              : MediaQuery.of(context).size.height * 0.12,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OKAY"),
          ),
        )
      ],
    );
  }
}