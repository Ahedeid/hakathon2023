import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  savePref() async {
    await Provider.of<AuthProvider>(context, listen: false)
        .login(_emailController.text);
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
                      'Login',
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
                  'Fill the following information to access your account!',
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(AppColor.primaryTextColor),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: midea.height * 0.03),
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
                  title: 'Login',
                ),
                SizedBox(height: midea.height * 0.08),
                InkWell(
                  onTap: () => AppRouter.goToAndRemove(
                      screenName: ScreenName.signUpScreen),
                  child: const Text.rich(
                    TextSpan(
                      text: 'Have an account?  ',
                      style: TextStyle(
                          fontSize: AppSizes.sizeTextMedium,
                          color: Color(AppColor.subColor)),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Sign Up',
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
