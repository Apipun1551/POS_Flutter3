part of 'product_report_bloc.dart';

@immutable
abstract class ProductReportState {
  const ProductReportState();
}

class ProductReportInitial extends ProductReportState {
  const ProductReportInitial();
}

class ProductReportLoading extends ProductReportState {
  const ProductReportLoading();
}

class ProductReportLoaded extends ProductReportState {
  final List<ProductReport> productReports;

  const ProductReportLoaded(this.productReports);
}

class ProductReportError extends ProductReportState {
  final String message;

  const ProductReportError(this.message);
}
