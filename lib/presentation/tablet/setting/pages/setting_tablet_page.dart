import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fic23pos_flutter/core/constants/colors.dart';
import 'package:fic23pos_flutter/core/assets/assets.gen.dart';
import 'package:fic23pos_flutter/presentation/tablet/setting/pages/manage_printer_tablet_page.dart';
import 'package:fic23pos_flutter/core/constants/variables.dart';
import 'package:fic23pos_flutter/core/components/spaces.dart';
import 'package:fic23pos_flutter/presentation/tablet/setting/pages/report_tablet_page.dart';

class SettingTabletPage extends StatefulWidget {
  const SettingTabletPage({super.key});

  @override
  State<SettingTabletPage> createState() => _SettingTabletPageState();
}

class _SettingTabletPageState extends State<SettingTabletPage> {
  int currentIndex = 0;

  void indexValue(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // LEFT CONTENT
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: AppColors.brand,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SpaceHeight(16.0),
                  // BUTTONS Setting Printer
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Image.asset(
                      Assets.images.managePrinter.path,
                      fit: BoxFit.contain,
                    ),
                    title: const Text('Manage Printer'),
                    subtitle: const Text('Manage printer in your store'),
                    textColor: AppColors.brand,
                    tileColor: currentIndex == 0
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(0),
                  ),
                  // BUTTONS Report
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Image.asset(
                      Assets.images.report.path,
                      fit: BoxFit.contain,
                    ),
                    title: const Text('Report'),
                    subtitle: const Text('Show report data'),
                    textColor: AppColors.brand,
                    tileColor: currentIndex == 1
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(1),
                  ),
                ],
              ),
            ),
          ),

          // RIGHT CONTENT
          Expanded(
            flex: 4,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IndexedStack(
                  index: currentIndex,
                  children: [
                    const ManagePrinterTabletPage(),
                    const ReportTabletPage(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
