// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_task/comman/widgets.dart';
import 'package:flutter_task/constants/appsizes.dart';
import 'package:flutter_task/constants/colors.dart';
import 'package:flutter_task/constants/strings.dart';
import 'package:flutter_task/providers/signin_api_provider.dart';
import 'package:flutter_task/screens/home.dart';
import 'package:flutter_task/utils/app_preference.dart';
import 'package:flutter_task/utils/prefrence_constant.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class TabSignIn extends StatefulWidget {
  const TabSignIn({Key? key}) : super(key: key);

  @override
  State<TabSignIn> createState() => _TabSignInState();
}

class _TabSignInState extends State<TabSignIn> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isclick = false;

  String? validateEmail(String? value) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value) ? "Invalid Email" : null;
  }

  final _formKey = GlobalKey<FormState>();

  signInAPi(context) async {
    Map peram = {
      "email": emailcontroller.text.toString(),
      "password": passwordcontroller.text.toString(),
    };
    var provider = Provider.of<SignInApiProvider>(context, listen: false);
    await provider.signInPostApi(AppStrings.signinkey, peram, context);

    if (!provider.isLoading) {
      var response = provider.signin_response;
      if (response.isNotEmpty) {
        isclick = false;
        setState(() {});

        var jsonResponse = response as Map<String, dynamic>;
        await AppPreference.put(pref_email, jsonResponse["record"]["email"]);
        await AppPreference.put(pref_accesstoken, jsonResponse["record"]["authtoken"]);
        await AppPreference.put(pref_name,
            "${jsonResponse["record"]["firstName"]} ${jsonResponse["record"]["lastName"]}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        isclick = false;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UIAppColors.white,
        body: Form(
            key: _formKey,
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                  child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gapH12,
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value!.isEmpty
                                  ? "This field is required"
                                  : validateEmail(value),
                              cursorColor: Colors.grey,
                              controller: emailcontroller,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                              decoration: const InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "Enter your Email",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: UIAppColors.pinbordercolor,
                                        width: 1.4),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: UIAppColors.textcolor,
                                          width: 1.4),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: UIAppColors.pinbordercolor,
                                          width: 1.4),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: UIAppColors.textcolor,
                                        width: 1.4),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: UIAppColors.pinbordercolor,
                                        width: 1.4),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  )),
                              onChanged: (mobile) {
                                setState(() {
                                  // _validateMobile = true;
                                  // _textMobile = mobile;
                                });
                              }),
                        ),
                      ],
                    ),
                    gapH24,
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value!.isEmpty
                                  ? "This field is required"
                                  : value.length < 8
                                      ? "Please enter atleast 8 character"
                                      : null,
                              cursorColor: Colors.grey,
                              controller: passwordcontroller,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                              decoration: const InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "Enter your password",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: UIAppColors.pinbordercolor,
                                        width: 1.4),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: UIAppColors.textcolor,
                                          width: 1.4),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: UIAppColors.pinbordercolor,
                                          width: 1.4),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: UIAppColors.textcolor,
                                        width: 1.4),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: UIAppColors.pinbordercolor,
                                        width: 1.4),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  )),
                              onChanged: (mobile) {
                                setState(() {
                                  // _validateMobile = true;
                                  // _textMobile = mobile;
                                });
                              }),
                        ),
                      ],
                    ),
                    gapH24,
                    InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_formKey.currentState!.validate()) {
                            if (!isclick) {
                              isclick = true;
                              setState(() {});
                              signInAPi(context);
                            }
                          }
                        },
                        child: Stack(
                          children: [
                            signupbtn(isclick ? "" : "Login"),
                            Positioned(
                                top: 0,
                                right: 0,
                                bottom: 0,
                                left: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isclick
                                        ? LoadingAnimationWidget.fallingDot(
                                            color: Colors.white,
                                            size: 50,
                                          )
                                        : Container()
                                  ],
                                ))
                          ],
                        )),
                    gapH12,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: UIAppColors.textcolor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    gapH16,
                    Column(children: [
                      gapH24,
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            color: Colors.black,
                            height: 2,
                          )),
                          gapW12,
                          const Text(
                            "Or signin with",
                            style: TextStyle(
                              color: UIAppColors.textcolor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          gapW12,
                          Expanded(
                              child: Container(
                            color: Colors.black,
                            height: 2,
                          )),
                        ],
                      ),
                      gapH16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/facebook.png",
                            height: 50,
                          ),
                          gapW16,
                          Image.asset("assets/google.png", height: 50),
                          gapW16,
                          Image.asset("assets/apple.png", height: 50)
                        ],
                      ),
                      gapH24,
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have a Account?",
                              style: TextStyle(
                                color: UIAppColors.textcolor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ])
                    ]),
                    gapH20,
                  ],
                ),
              ));
            })));
  }
}
