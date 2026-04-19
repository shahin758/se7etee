import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7etee/core/constants/user_type_enum.dart';
import 'package:se7etee/core/services/firebase/failures/failure.dart';
import 'package:se7etee/features/auth/data/model/auth_params.dart';
import 'package:se7etee/features/auth/data/repo/auth_repo.dart';
import 'package:se7etee/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(AuthLoadingState());
    var params = AuthParams(
      email: emailController.text,
      password: passwordController.text,
    );
    Either<Failure, UserTypeEnum> data = await AuthRepo.login(params);
    data.fold(
      (failure) {
        emit(AuthFailureState(errorMessage: failure.message));
      },
      (userType) {
        emit(AuthSuccessState(userType: userType));
      },
    );
  }

  Future<void> register(UserTypeEnum userType) async {
    emit(AuthLoadingState());

    var params = AuthParams(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    Either<Failure, Unit> data;

    if (userType == UserTypeEnum.doctor) {
      data = await AuthRepo.registerDoctor(params);
    } else {
      data = await AuthRepo.registerPatient(params);
    }
    data.fold(
      (failure) {
        emit(AuthFailureState(errorMessage: failure.message));
      },
      (r) {
        emit(AuthSuccessState());
      },
    );
  }
}
