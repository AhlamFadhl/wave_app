import 'package:wave_app/shared/utils/functions.dart';

class Validation {
  static String? fieldTimeValidate(val) {
    return val!.isEmpty ? 'الرجاء ادخال توقيت صحيح' : null;
  }

  static String? firstnameValidate(val) {
    return val!.isEmpty ? 'ادخل اسمك الأول' : null;
  }

  static String? lastnameValidate(val) {
    return val!.isEmpty ? 'اكتب اسمك الأخير' : null;
  }

  static String? phoneValidate(val) {
    return val!.isEmpty ? 'اكتب رقم الجوال' : null;
  }

  static String? emailValidate(val) {
    return val!.isEmpty
        ? 'اكتب البريد الإلكتروني'
        : val.toString().isValidEmail()
            ? "البريد الإلكتروني غير صالح"
            : null;
  }

  static String? passwordValidate(val) {
    return val!.isEmpty ? 'اكتب كلمة السر' : null;
  }

  static String? noValdation(val) {
    return null;
  }
}
