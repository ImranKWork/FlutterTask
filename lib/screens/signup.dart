// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_task/comman/widgets.dart';
import 'package:flutter_task/constants/appsizes.dart';
import 'package:flutter_task/constants/colors.dart';
import 'package:flutter_task/constants/strings.dart';
import 'package:flutter_task/providers/signup_api_provider.dart';
import 'package:flutter_task/screens/home.dart';
import 'package:flutter_task/utils/app_preference.dart';
import 'package:flutter_task/utils/prefrence_constant.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class TabSignUp extends StatefulWidget {
  const TabSignUp({Key? key}) : super(key: key);

  @override
  State<TabSignUp> createState() => _TabSignUpState();
}

class _TabSignUpState extends State<TabSignUp> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();
  bool isclick = false;

  String? validateEmail(String? value) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value) ? "Invalid Email" : null;
  }

  String? password(String? value) {
    return value == passwordcontroller.text.toString()
        ? null
        : "Enter Invalid Password";
  }

  final _formKey = GlobalKey<FormState>();

  signupAPi(context) async {
    Map peram = {
      "first_name": firstnamecontroller.text.toString(),
      "last_name": lastnamecontroller.text.toString(),
      "country_code": "+91",
      "phone_no": phonenumbercontroller.text.toString(),
      "email": emailcontroller.text.toString(),
      "password": passwordcontroller.text.toString(),
      "confirm_password": confirmpasscontroller.text.toString(),
    };
    var provider = Provider.of<SignUpApiProvider>(context, listen: false);
    await provider.signupPostApi(AppStrings.signupkey, peram, context);

    if (!provider.isLoading) {
      var response = provider.signup_response;
      if (response.isNotEmpty) {
        isclick = false;
        setState(() {});
        var jsonResponse = response as Map<String, dynamic>;

        await AppPreference.put(pref_email, jsonResponse["data"]["email"]);
        await AppPreference.put(pref_accesstoken, jsonResponse["data"]["token"]);
        await AppPreference.put(pref_name,
            "${firstnamecontroller.text.toString()} ${lastnamecontroller.text.toString()}");
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
                                  : null,
                              cursorColor: Colors.grey,
                              controller: firstnamecontroller,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                              decoration: const InputDecoration(
                                  labelText: 'First Name',
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  hintText: "Enter your first name",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
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
                                  : null,
                              cursorColor: Colors.grey,
                              controller: lastnamecontroller,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                              decoration: const InputDecoration(
                                  labelText: 'Last Name',
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "Enter your last name",
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
                                  : null,
                              cursorColor: Colors.grey,
                              controller: phonenumbercontroller,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                              maxLength: 10,
                              decoration: const InputDecoration(
                                  prefixText: "+91",
                                  labelText: 'Phone Number',
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "Enter your phone number",
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
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value!.isEmpty
                                  ? "This field is required"
                                  : password(value),
                              cursorColor: Colors.grey,
                              controller: confirmpasscontroller,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                              decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  hintText: "Enter your confirm password",
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
                              signupAPi(context);
                            }
                          }
                        },
                        child: Stack(
                          children: [
                            signupbtn(isclick ? "" : "SignUp"),
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
                    gapH20,
                  ],
                ),
              ));
            })));
  }
}
