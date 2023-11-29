// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rental_porch_app/presentation/enter_code.dart';
import 'package:rental_porch_app/services/email_service.dart';
import 'package:rental_porch_app/services/firebase_service.dart';

import '../utils/main_interface.dart';
import 'login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => ForgetPasswordScreenState();
}

class ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final TextEditingController _emailControllerReg = TextEditingController();
  static Map<String, dynamic> dataUser = {};
  static late int code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 90.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.all(10),
                  child: const Icon(Icons.settings_backup_restore_outlined, size: 100,)
                ),
                const Text('Restauración de contraseña', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),),
                const SizedBox(height: 20,),
                const Text('Ingresa tu email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                
                const SizedBox(height: 30,),
                TextField(
                  controller: _emailControllerReg,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: 'Ejemplo: porch@gmail.com',
                    labelText: 'Email',
                    suffixIcon: const Icon(
                      Icons.alternate_email,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: ()async{
                    code = Random().nextInt(8999)+1000;
                    if(await searchUserByEmail(_emailControllerReg.text)){
                      await sendEmailForCode(name: dataUser['name'], toEmail: _emailControllerReg.text, message: 'Su código de recuperación es '+code.toString());
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EnterCodeScreen()));
                    }
                    else{
                      showMessage(context, 'El email no esa vinculado a ninguna cuenta de Rental Porch', const Color.fromARGB(126, 255, 0, 0));
                    }
                    
                  }, 
                  child: const Text(
                    'Enviar código', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue ),
                  )
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: ()async{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                  }, 
                  child: const Text(
                    'Cancelar', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent ),
                  )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}