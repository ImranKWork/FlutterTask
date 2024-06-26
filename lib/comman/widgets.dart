import 'package:flutter/material.dart';
import 'package:flutter_task/constants/colors.dart';
import 'package:flutter_task/constants/strings.dart';

Widget signupbtn(
  namebtn,
) {
  return Container(
    height: 52,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), color: UIAppColors.subgreen),
    child: Center(
        child: Text(
      namebtn,
      style: const TextStyle(
        color: UIAppColors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    )),
  );
}

errorbox(context, msg) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                msg,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      UIAppColors.blackn, // Set the background color
                  foregroundColor:
                      UIAppColors.blackn, // Set the text color to white
                  padding: EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ), // Increase horizontal padding
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: UIAppColors.blackn,
                  ),
                  minimumSize: Size(double.infinity,
                      30), // Increase the minimum width to full screen
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Add rounded corners
                    side: BorderSide(
                      color: UIAppColors.blackn,
                      width: 2.0,
                    ), // Add rounded corners
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the row content
                  children: [
                    SizedBox(
                        width: 10), // Add some space between the icon and text
                    Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      });
}
