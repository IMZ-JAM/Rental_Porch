import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';


//Mensaje que dura unos segundos
void showMessage(BuildContext context, String label, Color colorBackGround) {
  showToast(
    label,
    context: context,
    position: StyledToastPosition.top,
    duration: const Duration(seconds: 4),
    curve: Curves.easeIn,
    reverseCurve: Curves.easeOut,
    backgroundColor: colorBackGround,
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 0, 0,0)
    ),
    animation: StyledToastAnimation.fade,
    reverseAnimation: StyledToastAnimation.fade,
    animDuration: const Duration(seconds: 1),
    
    );
}



//Para ver si es un numero de telefono
bool isPhoneNumber(String phoneNumber) {
  return RegExp(r'^[0-9]+$').hasMatch(phoneNumber) && phoneNumber.length==10;
}

//Para ver si en algun textfield no hay nada o hay puros espacios vacios
bool isStringNotEmpty(String text) {
  // ignore: unnecessary_null_comparison
  if(text == null) {
    return false;
  }
  return text.trim().isNotEmpty;
}