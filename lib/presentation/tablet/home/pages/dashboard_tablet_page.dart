import 'package:flutter/material.dart';
import 'package:fic23pos_flutter/core/assets/assets.gen.dart';
import 'package:fic23pos_flutter/core/constants/colors.dart';
import 'package:fic23pos_flutter/core/extensions/build_context_ext.dart';
import 'package:fic23pos_flutter/presentation/auth/pages/login_page.dart';
import 'package:fic23pos_flutter/presentation/home/widgets/nav_item.dart';
import 'package:fic23pos_flutter/presentation/tablet/history/pages/history_tablet_page.dart';
import 'package:fic23pos_flutter/presentation/tablet/home/pages/home_tablet_page.dart';
import 'package:fic23pos_flutter/presentation/tablet/home/pages/products_tablet_page.dart';
import 'package:fic23pos_flutter/presentation/tablet/setting/pages/setting_tablet_page.dart';

class DashboardTabletPage extends StatefulWidget {
  const DashboardTabletPage({super.key});

  @override
  State<DashboardTabletPage> createState() => _DashboardTabletPageState();
}

class _DashboardTabletPageState extends State<DashboardTabletPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeTabletPage(),
    const HistoryTabletPage(),
    const ProductsTabletPage(),
    const SettingTabletPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            SingleChildScrollView(
              child: Container(
                height: context.deviceHeight - 20.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(16.0),
                  ),
                  color: AppColors.brand, //side bar
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -2),
                      blurRadius: 30.0,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 0,
                      color: AppColors.black.withOpacity(0.08),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    NavItem(
                      iconPath: Assets.icons.home.path,
                      label: '',
                      isActive: _selectedIndex == 0,
                      onTap: () => _onItemTapped(0),
                      isTablet: true,
                    ),
                    NavItem(
                      iconPath: Assets.icons.history.path,
                      label: '',
                      isActive: _selectedIndex == 1,
                      onTap: () => _onItemTapped(1),
                      isTablet: true,
                    ),
                    NavItem(
                      iconPath: Assets.icons.snack.path,
                      label: '',
                      isActive: _selectedIndex == 2,
                      onTap: () => _onItemTapped(2),
                      isTablet: true,
                    ),
                    NavItem(
                      iconPath: Assets.icons.dashboard.path,
                      label: '',
                      isActive: _selectedIndex == 3,
                      onTap: () => _onItemTapped(3),
                      isTablet: true,
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.logout, color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),
      ),
    );
  }
}
