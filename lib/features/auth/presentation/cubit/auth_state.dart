import 'package:se7etee/core/constants/user_type_enum.dart';

class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserTypeEnum? userType;
  AuthSuccessState({ this.userType});
}

class AuthFailureState extends AuthState {
  final String errorMessage;
  AuthFailureState({required this.errorMessage});
}
