import 'package:flutter/material.dart';
import 'package:flutter_task/constants/colors.dart';
import 'package:flutter_task/screens/signin.dart';
import 'package:flutter_task/screens/signup.dart';
import '../constants/appsizes.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: UIAppColors.white,
            body: Stack(
              children: [
                Positioned(
                    left: 0,
                    top: 0,
                    child: Image.asset(
                      "assets/topleft.png",
                      height: 270,
                    )),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      "assets/bottomright.png",
                      height: 270,
                    )),
                Positioned(
                  left: 0,
                  top: 70,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gapH8,
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: AppBar(
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          bottom: TabBar(
                            controller: _tabController,
                            dividerColor: Colors.white,
                            unselectedLabelColor: UIAppColors.unselectedcolor,
                            labelColor: Colors.black,
                            indicatorColor: UIAppColors.intro2backcolor,
                            indicator: const UnderlineTabIndicator(
                                borderSide: BorderSide(
                                    width: 2.0,
                                    color: UIAppColors.intro2backcolor),
                                insets:
                                    EdgeInsets.symmetric(horizontal: 50.35)),
                            tabs: const [
                              Tab(text: "Sign in"),
                              Tab(
                                child: Text(
                                  "Sign up",
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      gapH12,
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            TabSignIn(),
                            TabSignUp(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
