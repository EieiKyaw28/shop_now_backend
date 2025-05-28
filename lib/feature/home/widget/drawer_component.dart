import 'package:flutter/material.dart';
import 'package:shop_now_backend/constant/extensions.dart';
import 'package:shop_now_backend/constant/my_theme.dart';
import 'package:shop_now_backend/constant/route_list.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profile",
            style: TextStyle(fontSize: 16, color: MyTheme.whiteColor),
          ),
          20.vGap,
          ListView.separated(
            separatorBuilder: (_, _) {
              return SizedBox(height: 10);
            },
            physics: NeverScrollableScrollPhysics(),
            itemCount: routeList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = routeList[index];
              return InkWell(
                onTap: () {
                  onSelected(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color:
                        selectedIndex == index
                            ? MyTheme.bgColor
                            : Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          color:
                              selectedIndex == index
                                  ? MyTheme.purpleShade2
                                  : MyTheme.bgColor,
                          item.icon,
                          height: selectedIndex == index ? 24 : 20,
                          width: selectedIndex == index ? 24 : 20,
                        ),
                        10.hGap,
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: selectedIndex == index ? 16 : 14,
                            color:
                                selectedIndex == index
                                    ? MyTheme.purpleShade2
                                    : MyTheme.bgColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
