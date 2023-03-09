
extension ExtString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z\d.]+@[a-zA-Z\d]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
    RegExp(r"^\s*([A-Za-z]+([.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#><*~])');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}