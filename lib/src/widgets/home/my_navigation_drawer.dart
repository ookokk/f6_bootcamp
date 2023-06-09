import 'package:flutter/material.dart';
import 'package:giyin/src/constants/text_style.dart';
import 'package:provider/provider.dart';
import '../../constants/color.dart';
import '../../service/auth/auth_provider.dart';

class MyNavigationDrawer extends StatelessWidget {
  MyNavigationDrawer({Key? key}) : super(key: key);
  final AuthProvider authProvider = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      return Drawer(
        elevation: 100,
        width: MediaQuery.of(context).size.width * 0.75,
        backgroundColor: CustomColors.kKoyuBeyazBG,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Align(
                child: ClipOval(
                    child: Image.asset(
                  "assets/images/profile.png",
                  height: MediaQuery.of(context).size.height * 0.22,
                )),
              )),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FutureBuilder<String?>(
                    future: authProvider.getCurrentUserEmail(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        return buildDrawerListTileCard(
                          context,
                          "assets/icons/wrong-password.png",
                          snapshot.data!,
                          () {},
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          "Error: ${snapshot.error}",
                          style: const TextStyle(color: Colors.red),
                        );
                      } else {
                        return const Text(
                          "No user email found.",
                          style: TextStyle(color: Colors.red),
                        );
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: buildDrawerListTileCard(
                      context, "assets/icons/logout.png", "Sign Out", () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return buildSignOutAlertDialog(context);
                      },
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  AlertDialog buildSignOutAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Sign Out",
        style: kMediumLargeBText,
      ),
      content: Text(
        "Do you really want to log out?",
        style: kMediumText,
      ),
      actions: [
        TextButton(
          child: Text("No", style: kMediumText),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text("Yes", style: kMediumText),
          onPressed: () {
            Navigator.pop(context);
            authProvider.signUserOut();
            Navigator.pushReplacementNamed(context, '/auth');
          },
        ),
      ],
    );
  }

  Widget buildMenuItems(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            buildDrawerListTileCard(
                context, "assets/icons/clothes.png", "Add Clothe", () {
              Navigator.pushNamed(context, '/addClothe');
            }),
            const SizedBox(height: 16),
            buildDrawerListTileCard(
              context,
              "assets/icons/closet.png",
              "My Combinations",
              () {
                Navigator.pushNamed(context, '/combinations');
              },
            ),
            const SizedBox(height: 16),
            buildDrawerListTileCard(
                context,
                "assets/icons/create_combination.png",
                "Create Combination", () {
              Navigator.pushNamed(context, '/createCombination');
            }),
          ],
        ),
      );

  Widget buildDrawerListTileCard(BuildContext context, String image,
      String text, final Function()? onTap) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(color: CustomColors.kKoyuBeyazBG, width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        leading: SizedBox(
          width: 50,
          child: Image.asset(
            image,
            height: 50,
          ),
        ),
        title: Text(
          text,
          style: kMediumText,
        ),
        onTap: onTap,
      ),
    );
  }
}
