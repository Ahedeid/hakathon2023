import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hakathon2023/utils/extnsions_validation.dart';
import 'package:provider/provider.dart';
import '../../provider/userLoggedIn.dart';
import '../../routes/app_router.dart';
import '../../routes/screen_name.dart';
import '../../utils/colors_manger.dart';
import '../../utils/images_constant.dart';
import '../../utils/sizes_in_app.dart';
import '../widget/my_button.dart';
import '../widget/my_textFeild.dart';

class SignUpScreen extends StatefulWidget {
   const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  savePref() async {
    await Provider.of<AuthProvider>(context,listen: false)
        .signUp(_emailController.text, _nameController.text);
    AppRouter.goToAndRemove(screenName: ScreenName.homeScreen);
  }
  @override
  Widget build(BuildContext context) {
    var midea = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: midea.height * 0.2),
                SizedBox(
                    height: 100,
                    width: 100,
                    child: SvgPicture.asset(ImageConstant.logo)),
                SizedBox(height: midea.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 30,
                          color: Color(AppColor.primaryTextColor),
                          fontWeight: FontWeight.bold),
                    ),
                    Text('')
                  ],
                ),
                SizedBox(height: midea.height * 0.01),
                const Text(
                  'Fill the following information to create an account',
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(AppColor.primaryTextColor),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: midea.height * 0.03),
                MyTextField(
                  controller: _nameController,
                  validator: (val) {
                    if (!val!.isValidName) return 'Enter valid Name';
                  },
                  hintText: 'Name',
                  obscureText: false,
                  keyboardType: TextInputType.name, icon: '',
                ),
                SizedBox(height: midea.height * 0.02),
                MyTextField(
                  controller: _emailController,
                  validator: (val) {
                    if (!val!.isValidEmail) return 'Enter valid email';
                  },
                  hintText: 'email@hotmail.com',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress, icon: '',
                ),
                SizedBox(height: midea.height * 0.02),
                MyButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        savePref();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Welcome to App!')),
                        );
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    }
                  },
                  title: 'Sign Up',
                ),
                SizedBox(height: midea.height * 0.08),
                InkWell(
                  onTap: () => AppRouter.goToAndRemove(
                      screenName: ScreenName.signInScreen),
                  child: const Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                          fontSize: AppSizes.sizeTextMedium,
                          color: Color(AppColor.subColor)),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Color(AppColor.buttonColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
