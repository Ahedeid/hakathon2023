import 'package:flutter/material.dart';
import '../../utils/colors_manger.dart';
import '../../utils/sizes_in_app.dart';



class MyButton extends StatelessWidget {
  MyButton({
   required this.title,
    this.onPressed,
    super.key,
  });
  void Function()? onPressed;

  String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        color: const Color(AppColor.buttonColor)
          ),
      child: ElevatedButton(
        onPressed: onPressed ,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child:  Text(
          title,
          style: const TextStyle(
            fontSize: AppSizes.sizeTextMedium,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}