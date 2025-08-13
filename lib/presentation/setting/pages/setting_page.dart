import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic23pos_flutter/core/constants/colors.dart';
import 'package:fic23pos_flutter/core/extensions/build_context_ext.dart';
import 'package:fic23pos_flutter/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:fic23pos_flutter/presentation/auth/pages/login_page.dart';

import 'package:fic23pos_flutter/presentation/home/pages/dashboard_page.dart';
import 'package:fic23pos_flutter/presentation/setting/pages/manage_printer_page.dart';
import 'package:fic23pos_flutter/presentation/setting/pages/report_page.dart';

import 'package:fic23pos_flutter/core/constants/variables.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/menu_button.dart';
import '../../../core/components/spaces.dart';

// Tambahan import untuk download dan buka file
import 'dart:io';
import 'package:dio/dio.dart'; // Untuk HTTP request
import 'package:path_provider/path_provider.dart'; // Untuk mendapatkan folder sementara
import 'package:open_file/open_file.dart'; // Untuk membuka file setelah download

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

  // === Implementasi ke backend ===

  // === End implementasi ke backend ===

class _SettingPageState extends State<SettingPage> {
  // Membuat instance Dio untuk request ke backend Laravel
  final Dio _dio = Dio(BaseOptions(
    baseUrl: '${Variables.baseUrl}/api', // Ganti dengan URL API Laravel
    responseType: ResponseType.bytes, // Agar bisa menerima file dalam bentuk bytes
  ));

  // Fungsi generic untuk download file dari Laravel API
  Future<void> _downloadFile(String url, String fileName) async {
    try {
      final response = await _dio.get<List<int>>(
        url,
        options: Options(
          responseType: ResponseType.bytes, // Pastikan menerima bytes
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      // Mendapatkan folder sementara untuk menyimpan file
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName');

      // Menyimpan bytes ke file
      await file.writeAsBytes(response.data!);

      // Tampilkan notifikasi berhasil download
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$fileName berhasil di-download!')),
      );

      // Buka file secara otomatis menggunakan aplikasi bawaan
      await OpenFile.open(file.path);
    } catch (e) {
      // Notifikasi jika download gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal download file: $e')),
      );
    }
  }

  // Fungsi untuk export PDF
  void _exportPdf() {
    _downloadFile('/reports/pdf', 'report.pdf'); // memanggil route Laravel PDF
  }

  // Fungsi untuk export Excel
  void _exportExcel() {
    _downloadFile('/reports/excel', 'report.xlsx'); // memanggil route Laravel Excel
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            context.push(const DashboardPage());
          },
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SpaceHeight(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Flexible(
                    child: MenuButton(
                      iconPath: Assets.images.report.path,
                      label: 'Report',
                      onPressed: () {
                        // Navigate to ReportPage
                        // You can replace this with your actual report page navigation
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReportPage()),
                        );
                      },

                      // => context.push(const ReportPage()),
                      isImage: true,
                    ),
                  ),
                  const SpaceWidth(15.0),
                  Flexible(
                    child: MenuButton(
                      iconPath: Assets.images.managePrinter.path,
                      label: 'Setting Printer',
                      onPressed: () {
                        context.push(const ManagePrinterPage());
                      },
                      isImage: true,
                    ),
                  ),
                ],
              ),
            ),
            const SpaceHeight(30),

            // === Menu Export PDF / Excel ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Flexible(
                    child: MenuButton(
                      iconPath: Assets.images.pdf.path,
                      label: 'Export PDF',
                      onPressed: _exportPdf, // panggil fungsi _exportPdf
                      isImage: true,
                    ),
                  ),
                  const SpaceWidth(15.0),
                  Flexible(
                    child: MenuButton(
                      iconPath: Assets.images.excel.path,
                      label: 'Export Excel',
                      onPressed: _exportExcel, // panggil fungsi _exportExcel
                      isImage: true,
                    ),
                  ),
                ],
              ),
            ),
            // End Menu Import

            // ==== START: Tombol Export PDF dan Export Excel ====
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Column(
            //     children: [
            //       ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.blueAccent,
            //           minimumSize: const Size(double.infinity, 50),
            //         ),
            //         onPressed: _exportPdf, // Panggil fungsi export PDF
            //         child: const Text(
            //           'Export PDF',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //           ),
            //         ),
            //       ),
            //       const SizedBox(height: 12),
            //       ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.green,
            //           minimumSize: const Size(double.infinity, 50),
            //         ),
            //         onPressed: _exportExcel, // Panggil fungsi export Excel
            //         child: const Text(
            //           'Export Excel',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // ==== END: Tombol Export PDF dan Export Excel ====
            const SpaceHeight(60),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 208, 123, 137),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  //clear auth
                  // AuthLocalDatasource().clearAuthData();
                  context.read<LogoutBloc>().add(LogoutEvent.logout());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
