import 'package:flutter/material.dart';
import 'package:shop_now_backend/constant/extensions.dart';
import 'package:shop_now_backend/constant/my_theme.dart';
import 'package:shop_now_backend/constant/route_list.dart';
import 'package:shop_now_backend/feature/category/presentation/category_page.dart';
import 'package:shop_now_backend/feature/home/widget/drawer_component.dart';
import 'package:shop_now_backend/feature/product/presentation/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSelected = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyTheme.purpleShade1, MyTheme.purpleShade2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: DrawerComponent(
                  selectedIndex: selectedIndex,
                  onSelected: (i) {
                    selectedIndex = i;
                    setState(() {});
                  },
                ),
              ),
              Expanded(flex: 4, child: routeList[selectedIndex].page),
            ],
          ),
        ),
      ),
    );
  }
}
