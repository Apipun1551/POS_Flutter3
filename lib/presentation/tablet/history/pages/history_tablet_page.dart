import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic23pos_flutter/core/constants/colors.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../../core/components/spaces.dart';
import '../../../../data/datasource/auth_local_datasource.dart';
import '../../../../data/models/response/history_response_model.dart';
import '../../../history/bloc/history/history_bloc.dart';
import '../../../history/widgets/history_transaction_card.dart';

class HistoryTabletPage extends StatefulWidget {
  const HistoryTabletPage({super.key});

  @override
  State<HistoryTabletPage> createState() => _HistoryTabletPageState();
}

class _HistoryTabletPageState extends State<HistoryTabletPage> {
  @override
  void initState() {
    context.read<HistoryBloc>().add(const HistoryEvent.fetchHistories());
    _connectDefaultPrinter();
    super.initState();
  }

  Future<void> _connectDefaultPrinter() async {
    final defaultPrinter = await AuthLocalDatasource().getDefaultPrinter();
    if (defaultPrinter != null) {
      bool isConnected = await PrintBluetoothThermal.connectionStatus;
      if (!isConnected) {
        final connected = await PrintBluetoothThermal.connect(
          macPrinterAddress: defaultPrinter.macAddress,
        );
        print("Printer default connected: $connected");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'History Order',
              style: TextStyle(
                color: AppColors.brand,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            BlocBuilder<HistoryBloc, HistoryState>(
              builder: (context, state) {
                switch (state) {
                  case const HistoryState.loading():
                    return const Center(child: CircularProgressIndicator());
                  case Failure(message: String message):
                    return Center(
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  case Success(data: HistoryResponseModel data):
                    if (data.data == null || data.data!.isEmpty) {
                      return const Center(child: Text('No history found'));
                    } else {
                      return Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 28.0),
                          itemCount: data.data!.length,
                          separatorBuilder: (context, index) =>
                              const SpaceHeight(8.0),
                          itemBuilder: (context, index) =>
                              HistoryTransactionCard(
                                padding: paddingHorizontal,
                                data: data.data![index],
                              ),
                        ),
                      );
                    }
                  default:
                    return const Center(child: Text('Unexpected state'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
