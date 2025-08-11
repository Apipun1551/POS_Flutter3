import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic23pos_flutter/core/extensions/build_context_ext.dart';
import 'package:fic23pos_flutter/core/extensions/date_time_ext.dart';
import 'package:fic23pos_flutter/core/extensions/int_ext.dart';
import 'package:fic23pos_flutter/data/dataoutput/printer_service.dart';
import 'package:fic23pos_flutter/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:fic23pos_flutter/presentation/home/models/order_item.dart';
import 'package:fic23pos_flutter/presentation/home/pages/dashboard_page.dart';
import 'package:fic23pos_flutter/presentation/order/bloc/order/order_bloc.dart'
    as order_bloc;
import 'package:fic23pos_flutter/presentation/order/widgets/label_value_widget.dart';
import 'package:fic23pos_flutter/presentation/tablet/home/pages/dashboard_tablet_page.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';

class PaymentSuccessDialog extends StatelessWidget {
  final bool isTablet;
  const PaymentSuccessDialog({super.key, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Assets.icons.done.svg()),
          const SpaceHeight(24.0),
          const Text(
            'Payment has been successfully',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      content: BlocBuilder<order_bloc.OrderBloc, order_bloc.OrderState>(
        builder: (context, state) {
          switch (state) {
            case order_bloc.Success(
              paymentMethod: String paymentMethod,
              nominalBayar: int nominalBayar,
              orders: List<OrderItem> orders,
              totalQuantity: int totalQuantity,
              totalPrice: int totalPrice,
            ):
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelValue(label: 'Payment Method', value: paymentMethod),
                  const Divider(height: 16.0),
                  LabelValue(
                    label: 'Total Quantity',
                    value: totalQuantity.toString(),
                  ),
                  const Divider(height: 16.0),
                  LabelValue(
                    label: 'Total Bill',
                    value: totalPrice.currencyFormatRp,
                  ),
                  // const Divider(height: 16.0),
                  // LabelValue(label: 'Cashier Name', value: 'John Doe'),
                  const Divider(height: 16.0),
                  LabelValue(
                    label: 'Transaction Date',
                    value: DateTime.now().toFormattedTime(),
                  ),
                  const SpaceHeight(20.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Button.filled(
                          onPressed: () {
                            isTablet
                                ? context.pushReplacement(
                                    const DashboardTabletPage(),
                                  )
                                : context.pushReplacement(
                                    const DashboardPage(),
                                  );
                            context.read<CheckoutBloc>().add(
                              CheckoutEvent.started(),
                            );

                            context.read<order_bloc.OrderBloc>().add(
                              order_bloc.OrderEvent.started(),
                            );
                          },
                          label: 'Done',
                          fontSize: 12,
                        ),
                      ),
                      const SpaceWidth(12.0),
                      Flexible(
                        child: Button.outlined(
                          onPressed: () async {
                            final printValue = await PrinterService.instance
                                .printOrder(
                                  paymentMethod,
                                  orders,
                                  totalQuantity,
                                  totalPrice,
                                );

                            await PrintBluetoothThermal.writeBytes(printValue);
                          },
                          label: 'Print',
                          icon: Assets.icons.print.svg(),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            case _:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
