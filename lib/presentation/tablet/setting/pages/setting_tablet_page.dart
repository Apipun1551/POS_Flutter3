import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fic23pos_flutter/core/assets/assets.gen.dart';
import 'package:fic23pos_flutter/core/components/spaces.dart';
import 'package:fic23pos_flutter/core/constants/colors.dart';
import 'package:fic23pos_flutter/presentation/tablet/setting/pages/manage_printer_tablet_page.dart';
import 'package:fic23pos_flutter/presentation/tablet/setting/pages/report_tablet_page.dart';
import 'package:fic23pos_flutter/core/constants/variables.dart';
import 'package:fic23pos_flutter/core/components/menu_button.dart';


class SettingTabletPage extends StatefulWidget {
  const SettingTabletPage({super.key});

  @override
  State<SettingTabletPage> createState() => _SettingTabletPageState();
}

class _SettingTabletPageState extends State<SettingTabletPage> {
  // int currentIndex = 0;
  int currentIndex = 1;
  void indexValue(int index) {
    currentIndex = index;
    setState(() {});
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: '${Variables.baseUrl}/api',
    responseType: ResponseType.bytes,
  ));


  Future<void> _downloadFile(String url, String fileName) async {
    try {
      final response = await _dio.get<List<int>>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(response.data!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$fileName berhasil di-download!')),
      );

      await OpenFile.open(file.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal download file: $e')),
      );
    }
  }

  // void _exportPdf(BuildContext context) {
  //   _downloadFile(context, 'pdf', '/reports/pdf');
  // }

  // void _exportExcel(BuildContext context) {
  //   _downloadFile(context, 'xlsx', '/reports/excel');
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // LEFT SIDEBAR
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

                  // 1. Manage Printer
                  // ListTile(
                  //   contentPadding: const EdgeInsets.all(12.0),
                  //   leading: Image.asset(
                  //     Assets.images.managePrinter.path,
                  //     fit: BoxFit.contain,
                  //   ),
                  //   title: const Text('Manage Printer'),
                  //   subtitle: const Text('Manage printer in your store'),
                  //   textColor: AppColors.brand,
                  //   tileColor: currentIndex == 0
                  //       ? AppColors.blueLight
                  //       : Colors.transparent,
                  //   onTap: () => indexValue(0),
                  // ),

                  // 2. Report Penjualan
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Image.asset(
                      Assets.images.report.path,
                      fit: BoxFit.contain,
                    ),
                    title: const Text('Report Penjualan'),
                    subtitle: const Text('Show sales report data'),
                    textColor: AppColors.brand,
                    tileColor: currentIndex == 1
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(1),
                  ),

                  // 3. Export Data
                  ListTile(
                    contentPadding: const EdgeInsets.only(
                      left: 23,
                      top: 15,
                      right: 15,
                      bottom: 15,
                    ),
                    leading: Image.asset(
                      Assets.images.export.path,
                      fit: BoxFit.contain,
                    ),
                    title: const Text('Export Data'),
                    subtitle: const Text('Export PDF & Excel'),
                    textColor: AppColors.brand,
                    tileColor: currentIndex == 2
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(2),
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
                    const ManagePrinterTabletPage(), // halaman printer
                    const ReportTabletPage(), // halaman report 
                    const ExportTabletPage(), // halaman export
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

// ---------------------- Halaman Export Baru ----------------------
class ExportTabletPage extends StatelessWidget {
  const ExportTabletPage({super.key});

  // === LOGIKA DOWNLOAD FILE ===
  Future<void> _downloadFile(BuildContext context, String type, String endpoint) async {
    try {
      final Dio dio = Dio(BaseOptions(
        baseUrl: '${Variables.baseUrl}/api',
        responseType: ResponseType.bytes,
      ));

      final response = await dio.get<List<int>>(
        endpoint,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/report.$type');
      await file.writeAsBytes(response.data!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('report.$type berhasil di-download!')),
      );

      await OpenFile.open(file.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal download file: $e')),
      );
    }
  }

  // === PEMBUNGKUS AGAR MUDAH PANGGIL ===
  void _exportPdf(BuildContext context) {
    _downloadFile(context, 'pdf', '/reports/pdf');
  }

  void _exportExcel(BuildContext context) {
    _downloadFile(context, 'xlsx', '/reports/excel');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Export Data',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.brand,
          ),
        ),
        const SizedBox(height: 16),

        // Menu Export PDF
        ListTile(
          leading: Image.asset(Assets.images.pdf.path,width: 40,height: 40),
          title: const Text('Export PDF'),
          subtitle: const Text('Unduh laporan dalam format PDF'),
          onTap: () => _exportPdf(context),
        ),
        const Divider(height: 1),

        // Menu Export Excel
        ListTile(
          leading: Image.asset(Assets.images.excel.path,width: 40,height: 40),
          title: const Text('Export Excel'),
          subtitle: const Text('Unduh laporan dalam format Excel'),
          onTap: () => _exportExcel(context),
        ),
      ],
    );
  }
}