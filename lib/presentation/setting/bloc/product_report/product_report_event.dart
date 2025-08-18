part of 'product_report_bloc.dart';

abstract class ProductReportEvent {
  const ProductReportEvent();
}

class ProductReportInitialEvent extends ProductReportEvent {
  const ProductReportInitialEvent();
}

class GetProductReport extends ProductReportEvent {
  final String startDate;
  final String endDate;

  const GetProductReport(this.startDate, this.endDate);
}
