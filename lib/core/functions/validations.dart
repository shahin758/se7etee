bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  return emailRegex.hasMatch(email);
}

bool isEgyptianPhone(String phone) {
  final RegExp egyptianPhoneRegex = RegExp(r'^(010|011|012|015)\d{8}$');

  return egyptianPhoneRegex.hasMatch(phone);
}
