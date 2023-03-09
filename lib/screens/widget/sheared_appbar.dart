import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakathon2023/screens/widget/my_textFeild.dart';
import '../../utils/colors_manger.dart';
import '../../utils/images_constant.dart';
import '../../utils/sizes_in_app.dart';

class ShearedAppBar extends StatelessWidget with PreferredSizeWidget {
  const ShearedAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      child: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: AppSizes.hightAppBar,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: SvgPicture.asset(
          ImageConstant.logo,
          height: AppSizes.sizeLogoAppBar,
          width: AppSizes.sizeLogoAppBar,
        ),
        title: MyTextField(
          hintText: 'Search',
          obscureText: false,
          keyboardType: TextInputType.text,
          icon: '',
        ),
        actions: const [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Ahed Eid',
              style: TextStyle(
                  color: Color(AppColor.primaryTextColor),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(width: 5,),
          Icon(
            Icons.person,
            color: Color(AppColor.buttonColor),
            size: 30,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.hightAppBar);
}
