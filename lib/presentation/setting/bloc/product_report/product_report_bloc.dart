import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fic23pos_flutter/data/models/response/product_report_model.dart';
import 'package:fic23pos_flutter/data/datasource/report_remote_datasource.dart';
import 'package:flutter/foundation.dart';

part 'product_report_event.dart';
part 'product_report_state.dart';

class ProductReportBloc extends Bloc<ProductReportEvent, ProductReportState> {
  final ReportRemoteDatasource reportRemoteDatasource;

  ProductReportBloc(this.reportRemoteDatasource) : super(ProductReportInitial()) {
    on<GetProductReport>(_onGetProductReport);
  }

  Future<void> _onGetProductReport(
    GetProductReport event,
    Emitter<ProductReportState> emit,
  ) async {
    emit(ProductReportLoading());
    final result = await reportRemoteDatasource.getProductReport(
      event.startDate,
      event.endDate,
    );
    
    result.fold(
      (error) => emit(ProductReportError(error)),
      (data) => emit(ProductReportLoaded(data.data)),
    );
  }
}
