import 'package:flutter/material.dart';
import 'package:singer_app/config/color_config.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isDisabled;
  final Function? buttonPressed;
  Color? backgroundColor;
  Color? textColor;
  final double height;
  final double fontSize;

  CustomButton(this.title,
      {Key? key,
      this.isDisabled = false,
      this.buttonPressed,
      this.backgroundColor,
      this.textColor = Colors.white,
      this.height = 64,
      this.fontSize = 18,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isDisabled == false) {
          if (buttonPressed != null) {
            buttonPressed!();
          }
        }
      },
      child: Container(
        height: height,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: isDisabled ?  ColorConfig.accentColor.withOpacity(0.4) : ColorConfig.accentColor.withOpacity(0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 22),
              child: Text(
                title,
                style:  TextStyle(
                    color: textColor ?? Colors.white, fontSize: fontSize, letterSpacing: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
