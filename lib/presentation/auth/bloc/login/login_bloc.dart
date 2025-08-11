import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic23pos_flutter/data/datasource/auth_remote_datasource.dart';
import 'package:fic23pos_flutter/data/models/response/auth_response_model.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource authRemoteDatasource;
  LoginBloc(this.authRemoteDatasource) : super(Initial()) {
    on<_Login>((event, emit) async {
      emit(const Loading());
      final response = await authRemoteDatasource.login(
        event.email,
        event.password,
      );

      response.fold(
        (failure) => emit(Failure(failure)),
        (data) => emit(Success(data)),
      );
    });
  }
}
