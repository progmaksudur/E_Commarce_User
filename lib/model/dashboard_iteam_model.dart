import 'package:flutter/material.dart';

class DashboardItemModel {
  IconData icon;
  String title;

  DashboardItemModel({
    required this.icon,
    required this.title,
  });

  static const String product = "Products";
  static const String category = "Category";
  static const String order = "Orders";
  static const String user = "Users";
  static const String settings = "Settings";
  static const String report = "Report";
}

final List<DashboardItemModel> dashboardItems = [
  DashboardItemModel(
    icon: Icons.card_giftcard,
    title: DashboardItemModel.product,
  ),
  DashboardItemModel(
    icon: Icons.category,
    title: DashboardItemModel.category,
  ),
  DashboardItemModel(
    icon: Icons.monetization_on,
    title: DashboardItemModel.order,
  ),
  DashboardItemModel(
    icon: Icons.person,
    title: DashboardItemModel.user,
  ),
  DashboardItemModel(
    icon: Icons.settings,
    title: DashboardItemModel.settings,
  ),
  DashboardItemModel(
    icon: Icons.area_chart,
    title: DashboardItemModel.report,
  ),
];
