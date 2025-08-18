import 'dart:convert';
import 'dart:developer';

import 'package:fic23pos_flutter/presentation/tablet/setting/pages/report_tablet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic23pos_flutter/core/components/spaces.dart';
import 'package:fic23pos_flutter/core/constants/colors.dart';
import 'package:fic23pos_flutter/core/extensions/build_context_ext.dart';
import 'package:fic23pos_flutter/core/extensions/int_ext.dart';
import 'package:fic23pos_flutter/core/extensions/string_ext.dart';
import 'package:fic23pos_flutter/data/models/response/product_report_model.dart';
import 'package:fic23pos_flutter/presentation/tablet/setting/widgets/setting_title.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';

import '../../../../core/components/buttons.dart';
import '../../../setting/bloc/product_report/product_report_bloc.dart';
import '../../../setting/bloc/summary/summary_bloc.dart';
import 'package:fic23pos_flutter/data/datasource/report_remote_datasource.dart';

/// Wrapper sekaligus halaman
class ProductReportTabletPageWrapper extends StatelessWidget {
  const ProductReportTabletPageWrapper({super.key});
  String formatDate(DateTime date) {
    // Misal format yyyy-MM-dd sesuai backend Laravel
    return "${date.year.toString().padLeft(4,'0')}-"
          "${date.month.toString().padLeft(2,'0')}-"
          "${date.day.toString().padLeft(2,'0')}";
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductReportBloc>(
          create: (context) {
            final bloc = ProductReportBloc(ReportRemoteDatasource());
            // langsung fetch data saat Bloc dibuat
            bloc.add(GetProductReport(
              formatDate(DateTime.now().subtract(const Duration(days: 30))),
              formatDate(DateTime.now()),
            ));
            return bloc;
          },
        ),
        BlocProvider<SummaryBloc>(
          create: (context) => SummaryBloc(ReportRemoteDatasource()),
        ),
      ],
      child: ProductReportTabletPage(),
    );
  }
}

class ProductReportTabletPage extends StatefulWidget {
  const ProductReportTabletPage({super.key});

  @override
  State<ProductReportTabletPage> createState() =>
      _ProductReportTabletPageState();
}

class _ProductReportTabletPageState extends State<ProductReportTabletPage> {
  // DateTime selectedStartDate = DateTime.now().subtract(const Duration(days: 1));
  // DateTime selectedEndDate = DateTime.now();
  late DateTime selectedStartDate;
  late DateTime selectedEndDate;
  List<ProductReport> productReports = [];
  Summary? summary;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    selectedStartDate = DateTime(now.year, now.month, 1); // tgl 1 bulan ini
    selectedEndDate = DateTime(now.year, now.month + 1, 0); // tgl terakhir bulan ini

    String startDate = DateFormat('yyyy-MM-dd').format(selectedStartDate);
    String endDate = DateFormat('yyyy-MM-dd').format(selectedEndDate);
    _fetchData(startDate, endDate);
  }

  void _fetchData(String startDate, String endDate) {
    context.read<ProductReportBloc>().add(
      GetProductReport(startDate, endDate),
    );
    context.read<SummaryBloc>().add(
      SummaryEvent.getSummary(startDate, endDate),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SettingsTitle('Report Product'),
              const SpaceHeight(24),
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        DateFormat('dd MMM yyyy').format(selectedStartDate),
                        style: const TextStyle(
                          color: AppColors.brand,
                          fontSize: 12.0,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _selectStartDate(context),
                        icon: const Icon(
                          Icons.calendar_month,
                          color: AppColors.brand,
                        ),
                      ),
                    ],
                  ),
                  SpaceWidth(context.deviceWidth * 0.04),
                  const Text('-'),
                  SpaceWidth(context.deviceWidth * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd MMM yyyy').format(selectedEndDate),
                        style: const TextStyle(
                          color: AppColors.brand,
                          fontSize: 12.0,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _selectEndDate(context),
                        icon: const Icon(
                          Icons.calendar_month,
                          color: AppColors.brand,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: Button.filled(
                          onPressed: () {
                            String startDate = DateFormat(
                              'yyyy-MM-dd',
                            ).format(selectedStartDate);
                            String endDate = DateFormat(
                              'yyyy-MM-dd',
                            ).format(selectedEndDate);

                            _fetchData(startDate, endDate);
                          },
                          label: "Filter",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SpaceHeight(16.0),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.card.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SettingsTitle("Product Report"),
                    const SpaceHeight(16.0),
                    BlocBuilder<ProductReportBloc, ProductReportState>(
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case ProductReportLoading:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case ProductReportLoaded:
                            final reports =
                                (state as ProductReportLoaded).productReports;
                            productReports = reports;
                            if (reports.isEmpty) {
                              return const Center(
                                child: Text('No product report data available'),
                              );
                            }
                            return Column(
                              children: [
                                tableProductReport(reports),
                              ],
                            );
                          case ProductReportError:
                            final message =
                                (state as ProductReportError).message;
                            return Center(
                              child: Text('Error: $message'),
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tableProductReport(List<ProductReport> reports) {
    const double itemHeight = 55.0;
    final double tableHeight = itemHeight * reports.length;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: tableHeight + itemHeight,
        child: HorizontalDataTable(
          leftHandSideColumnWidth: 68,
          rightHandSideColumnWidth: 550,
          isFixedHeader: true,
          headerWidgets: _getTitleHeaderWidget(),
          leftSideItemBuilder: (context, index) {
            return Container(
              width: 68,
              height: 52,
              alignment: Alignment.centerLeft,
              child: Center(child: Text((index + 1).toString())),
            );
          },
          rightSideItemBuilder: (context, index) {
            final report = reports[index];
            return Row(
              children: <Widget>[
                Container(
                  width: 220,
                  height: 52,
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Center(child: Text(report.productName)),
                ),
                // Container(
                //   width: 130,
                //   height: 52,
                //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                //   alignment: Alignment.centerLeft,
                //   child: Center(
                //     child: Text(report.stock.toString()),
                //   ),
                // ),
                Container(
                  width: 95,
                  height: 52,
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Text(report.totalQuantity.toString()),
                  ),
                ),
                Container(
                  width: 190,
                  height: 52,
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Text(report.totalRevenue.currencyFormatRp),
                  ),
                ),
                // Container(
                //   width: 130,
                //   height: 52,
                //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                //   alignment: Alignment.centerLeft,
                //   child: Center(
                //     child: Text(report.profit.currencyFormatRp),
                //   ),
                // ),
              ],
            );
          },
          itemCount: reports.length,
          rowSeparatorWidget: const Divider(
            color: AppColors.black,
            height: 1.0,
            thickness: 0.0,
          ),
          leftHandSideColBackgroundColor: AppColors.white,
          rightHandSideColBackgroundColor: AppColors.white,
          itemExtent: 55,
        ),
      ),
    );
  }

  List<Widget> _getTitleHeaderWidget() {
    return [
      _getTitleItemWidget('No', 68),
      _getTitleItemWidget('Product', 200),
      _getTitleItemWidget('Stock', 130),
      //_getTitleItemWidget('Sold', 130),
      _getTitleItemWidget('Revenue', 165),
      //_getTitleItemWidget('Profit', 130),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      color: AppColors.brand,
      alignment: Alignment.centerLeft,
      child: Center(
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}