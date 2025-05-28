import 'package:flutter/widgets.dart';
import 'package:shop_now_backend/constant/image_string.dart';
import 'package:shop_now_backend/feature/category/presentation/category_page.dart';
import 'package:shop_now_backend/feature/order/presentation/order_page.dart';
import 'package:shop_now_backend/feature/product/presentation/product_page.dart';
import 'package:shop_now_backend/feature/stock/presentation/stock_page.dart';

class RouteModel {
  String title;
  String icon;
  Widget page;
  RouteModel({required this.title, required this.icon, required this.page});
}

List<RouteModel> routeList = [
  RouteModel(
    title: "Dashboard",
    icon: ImageString.dashboardIcon,
    page: SizedBox(),
  ),
  RouteModel(title: "Order", icon: ImageString.orderIcon, page: OrderPage()),
  RouteModel(
    title: "Category",
    icon: ImageString.categoryIcon,
    page: CategoryPage(),
  ),

  RouteModel(
    title: "Product",
    icon: ImageString.productIcon,
    page: ProductPage(),
  ),
  RouteModel(title: "Stock", icon: ImageString.stockIcon, page: StockPage()),
  RouteModel(
    title: "Widget Management",
    icon: ImageString.stockIcon,
    page: SizedBox(),
  ),
  RouteModel(title: "Chat", icon: ImageString.profileIcon, page: SizedBox()),
  RouteModel(title: "Profile", icon: ImageString.profileIcon, page: SizedBox()),
];
