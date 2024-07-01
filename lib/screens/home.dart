import 'package:flutter/material.dart';
import 'package:flutter_task/constants/appsizes.dart';
import 'package:flutter_task/constants/strings.dart';
import 'package:flutter_task/providers/home_api_provider.dart';
import 'package:flutter_task/providers/logout_api_provider.dart';
import 'package:flutter_task/screens/landingpage.dart';
import 'package:flutter_task/utils/app_preference.dart';
import 'package:flutter_task/utils/prefrence_constant.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

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

  bool loading = true;

  int pageKey = 1;
  final scorllcon = ScrollController();
  bool isLoadingmore = false;
  var data = [];

  Future<void> _scolllisner() async {
    if (scorllcon.position.pixels == scorllcon.position.maxScrollExtent) {
      setState(() {
        isLoadingmore = true;
      });
      pageKey = pageKey + 1;
      await homeapi();

      setState(() {
        isLoadingmore = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    homeapi();
    scorllcon.addListener(_scolllisner);
  }

  homeapi() async {
    var provider = Provider.of<HomeApiProvider>(context, listen: false);
    await provider.homePostApi(
        "${AppStrings.userlistkey}?page=$pageKey", context);

    if (!provider.isLoading) {
      var response = provider.home_response;
      if (response.isNotEmpty) {
        data = data + response;
        loading = false;
        setState(() {});
      }
    }
  }

  logoutpopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: ElevatedButton(
                onPressed: () async {
                  logoutapi();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFa83f4e), // Set the background color
                  foregroundColor:
                      const Color(0xFFa83f4e), // Set the text color to white
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ), // Increase horizontal padding
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFa83f4e),
                  ),
                  minimumSize: const Size(double.infinity,
                      30), // Increase the minimum width to full screen
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Add rounded corners
                    side: const BorderSide(
                      color: Color(0xFFa83f4e),
                      width: 2.0,
                    ), // Add rounded corners
                  ),
                ),
                child: const Row(
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
            const SizedBox(
                height: 10), // Add some space between the icon and text
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      fontSize: 15, color: Colors.black, fontFamily: 'Poppins'),
                ),
              ),
            ),
            const SizedBox(height: 10),
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
                        child: const Icon(Icons.logout))
                  ],
                ))),
        body: loading
            ? Center(
                child: LoadingAnimationWidget.fallingDot(
                color: Colors.blue,
                size: 100,
              ))
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
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
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
                                  color: isSelect ? Colors.blue : Colors.black,
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
                                  color: !isSelect ? Colors.blue : Colors.black,
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
                                controller: scorllcon,
                                mainAxisSpacing: 8.0,
                                children: List.generate(
                                    isLoadingmore
                                        ? data.length + 1
                                        : data.length, (index) {
                                  if (index < data.length) {
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
                                              data[index]["first_name"],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                            gapH4,
                                            Text(
                                              data[index]["last_name"],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                            gapH4,
                                            Text(
                                              data[index]["email"],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                            gapH4,
                                            Text(
                                              data[index]["phone_no"],
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
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                      ),
                                    );
                                  }
                                })))
                        : Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: isLoadingmore
                                    ? data.length + 1
                                    : data.length,
                                controller: scorllcon,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index < data.length) {
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
                                                      data[index]["first_name"],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    gapW6,
                                                    Text(
                                                      data[index]["last_name"],
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
                                                      data[index]["email"],
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
                                                      data[index]["phone_no"],
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
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                      ),
                                    );
                                  }
                                }))
                  ],
                ),
              ));
  }
}
