class SignupMixin {
  RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp nameReg = RegExp(r"^[A-Za-z]+(?:\s+[A-Za-z]+)*$");
  RegExp accountNumberReg = RegExp(r"^[0-9]+$");
  

  String? nomValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Veuillez saisir votre nom';
    }
    if (!nameReg.hasMatch(name)) {
      return 'Entrer un nom valide';
    }
    return null;
  }

  String? prenomValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Veuillez saisir votre prenom';
    }
    if (!nameReg.hasMatch(name)) {
      return 'Entrer un prenom valide';
    }
    return null;
  }

  String?  emailValidator(String? typedEmail) {
    if (typedEmail == null || typedEmail.isEmpty) {
      return 'Veuillez saisir votre adresse email';
    }
    if (!emailReg.hasMatch(typedEmail)) {
      return 'Entrer une adresse email valide';
    }

    return null;
  }

  String? accountNumberValidator(String? accountNumber) {
    if (accountNumber == null || accountNumber.isEmpty) {
      return 'Veuillez saisir votre numéro de compte';
    }
    if (!accountNumberReg.hasMatch(accountNumber)) {
      return 'Entrer un numéro de compte valide';
    }
    return null;
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Veuillez saisir votre mot de passe';
    }
    if (password.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }

  String? passwordConfirmationValidator(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Veuillez confirmer votre mot de passe';
    }
    if (password != confirmPassword) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }
}
