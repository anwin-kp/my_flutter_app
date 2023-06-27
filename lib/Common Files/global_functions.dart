bool isValidEmail(String email) {
  final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
  return emailRegex.hasMatch(email);
}

bool isPasswordValid(String password) {
  // Define your password validation rules here
  if (password.length < 8) {
    return false; // Password must be at least 8 characters
  }
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return false; // Password must contain at least one uppercase letter
  }
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return false; // Password must contain at least one special character
  }
  return true; // Password is valid
}

bool isValidFirstName(String firstName) {
  return firstName.length > 2 && RegExp(r'^[a-zA-Z]+$').hasMatch(firstName);
}

bool isValidLastName(String lastName) {
  return lastName.isNotEmpty && RegExp(r'^[a-zA-Z]+$').hasMatch(lastName);
}

bool isValidMobileNumber(String mobileNumber) {
  return mobileNumber.length == 10 &&
      RegExp(r'^[0-9]+$').hasMatch(mobileNumber);
}
