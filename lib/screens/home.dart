import 'package:flutter/material.dart';
import 'package:flutter_task/constants/appsizes.dart';
import 'package:flutter_task/constants/strings.dart';
import 'package:flutter_task/providers/home_api_provider.dart';
import 'package:flutter_task/providers/logout_api_provider.dart';
import 'package:flutter_task/screens/landingpage.dart';
import 'package:flutter_task/utils/app_preference.dart';
import 'package:flutter_task/utils/prefrence_constant.dart';
import 'package:provider/provider.dart';

import '../providers/signin_api_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSelect = false;
  logoutapi() async {
    var provider = Provider.of<LogoutApiProvider>(context, listen: false);
    await provider.logoutPostApi(AppStrings.logoutkey, context);

    if (!provider.isLoading) {
      var response = provider.logout_response;
      if (response.isNotEmpty) {
        AppPreference.prefs.clear();

        Future.delayed(Duration.zero, () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LandingPage()),
              ModalRoute.withName("/Home"));
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    homeapi();
  }

  homeapi() async {
    var provider = Provider.of<HomeApiProvider>(context, listen: false);
    await provider.homePostApi(AppStrings.userlistkey, context);

    if (!provider.isLoading) {
      var response = provider.home_response;
      if (response.isNotEmpty) {}
    }
  }

  logoutpopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Are you sure you want to logout?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: ElevatedButton(
                onPressed: () async {
                  logoutapi();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color(0xFFa83f4e), // Set the background color
                  foregroundColor:
                      Color(0xFFa83f4e), // Set the text color to white
                  padding: EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ), // Increase horizontal padding
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFa83f4e),
                  ),
                  minimumSize: Size(double.infinity,
                      30), // Increase the minimum width to full screen
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Add rounded corners
                    side: BorderSide(
                      color: Color(0xFFa83f4e),
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
                      'Log out',
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
            SizedBox(height: 10), // Add some space between the icon and text
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      fontSize: 15, color: Colors.black, fontFamily: 'Poppins'),
                ),
              ),
            ),

            SizedBox(height: 10),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55.0),
            child: AppBar(
                scrolledUnderElevation: 0.0,
                automaticallyImplyLeading: false,
                shadowColor: Colors.transparent,
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      "assets/profilepic.png",
                      height: 45,
                    ),
                    gapW12,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppPreference.prefs.getString(pref_name).toString(),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        gapH4,
                        Text(
                          AppPreference.prefs.getString(pref_email).toString(),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          logoutpopup();
                        },
                        child: Icon(Icons.logout))
                  ],
                ))),
        body: Consumer<HomeApiProvider>(builder: (context, data, child) {
          return data.isLoading
              ? Container()
              : Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "User list",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    isSelect = true;
                                    setState(() {});
                                  },
                                  child: Image.asset(
                                    "assets/gridlist.png",
                                    height: 22,
                                    color:
                                        isSelect ? Colors.blue : Colors.black,
                                  ),
                                ),
                                gapW16,
                                InkWell(
                                  onTap: () {
                                    isSelect = false;
                                    setState(() {});
                                  },
                                  child: Image.asset(
                                    "assets/list.png",
                                    height: 22,
                                    color:
                                        !isSelect ? Colors.blue : Colors.black,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      gapH12,
                      isSelect
                          ? Expanded(
                              child: GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  children: List.generate(
                                      data.home_response.length, (index) {
                                    return Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 1, color: Colors.grey),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.home_response[index]
                                                  ["first_name"],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                            gapH4,
                                            Text(
                                              data.home_response[index]
                                                  ["last_name"],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                            gapH4,
                                            Text(
                                              data.home_response[index]
                                                  ["email"],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                            gapH4,
                                            Text(
                                              data.home_response[index]
                                                  ["phone_no"],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                            gapH16,
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.blue),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                child: const Center(
                                                  child: Text(
                                                    "View Profile",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ));
                                  })))
                          : Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: data.home_response.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 10,
                                            bottom: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 1, color: Colors.grey),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data.home_response[index]
                                                          ["first_name"],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    gapW6,
                                                    Text(
                                                      data.home_response[index]
                                                          ["last_name"],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                gapH6,
                                                Row(
                                                  children: [
                                                    Text(
                                                      data.home_response[index]
                                                          ["email"],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                gapH6,
                                                Row(
                                                  children: [
                                                    Text(
                                                      data.home_response[index]
                                                          ["phone_no"],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.blue),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                                child: const Center(
                                                  child: Text(
                                                    "View Profile",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ));
                                  }))
                    ],
                  ),
                );
        }));
  }
}
