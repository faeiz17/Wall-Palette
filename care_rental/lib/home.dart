import 'package:care_rental/colors.dart';
import 'package:care_rental/porsche.dart';
import 'package:care_rental/widgets/horizontal_tab_bar.dart';
import 'package:care_rental/widgets/porche_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 8,
        child: Scaffold(
          body: Container(
            width: size.width,
            padding: const EdgeInsets.only(top: 16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [blackPrimary, blackSec],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  "assets/p_logo.png",
                  width: size.width * 0.4,
                  height: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                HorizontalTabBar(),
                SizedBox(
                  height: 3,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: porsche911Variants.length,
                    itemBuilder: (context, index) {
                      return PorscheCard(variant: porsche911Variants[index]);
                    },
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
