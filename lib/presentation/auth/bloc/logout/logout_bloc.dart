import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic23pos_flutter/data/datasource/auth_remote_datasource.dart';

part 'logout_bloc.freezed.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRemoteDatasource authRemoteDatasource;
  LogoutBloc(this.authRemoteDatasource) : super(Initial()) {
    on<_Logout>((event, emit) async {
      emit(Loading());
      final result = await authRemoteDatasource.logout();
      result.fold(
        (failure) => emit(Failure(failure)),
        (success) => emit(Success()),
      );
    });
  }
}
