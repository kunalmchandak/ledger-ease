class AppValidator {
  String? validateEmail(value) {
    if (value!.isEmpty) {
      return 'Please enter an Email Id';
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter valid Email Id';
    }
    return null;
  }

  // String? validatePhoneNumber(value) {
  //   if (value!.isEmpty) {
  //     return 'Please enter a Phone Number';
  //   }
  //   if (value.length != 10) {
  //     return 'Please enter a 10-digit Phone Number';
  //   }
  //   return null;
  // }

  String? validatePassword(value) {
    if (value!.isEmpty) {
      return 'Please enter a Password';
    }
    return null;
  }

  String? validateUsername(value) {
    if (value!.isEmpty) {
      return 'Please enter a Username';
    }
    return null;
  }

  String? isEmptyCheck(value) {
    if (value!.isEmpty) {
      return 'Please fill details';
    }
    return null;
  }
}