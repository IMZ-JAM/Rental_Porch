// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:rental_porch_app/presentation/forget_password_screen.dart';
import 'package:rental_porch_app/services/firebase_service.dart';
import 'package:rental_porch_app/utils/main_interface.dart';

import 'login_screen.dart';


class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({super.key});

  @override
  State<EnterCodeScreen> createState() => EnterCodeScreenState();
}

class EnterCodeScreenState extends State<EnterCodeScreen> {

  final TextEditingController _codeControllerReg = TextEditingController();
  static Map<String, dynamic> dataUser = {};
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
                const Text('Ingresa el código que llegó a tu email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                
                const SizedBox(height: 30,),
                TextField(
                  controller: _codeControllerReg,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    labelText: 'Código de recuperación',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: ()async{
                    if(_codeControllerReg.text == ForgetPasswordScreenState.code.toString()){
                      showMessage(context, 'Código correcto', const Color.fromARGB(127, 0, 255, 8));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const NewPasswordScreen()));
                    }
                    else{
                      showMessage(context, 'Código incorrecto', const Color.fromARGB(126, 255, 0, 0));
                    }
                  }, 
                  child: const Text(
                    'Confirmar codigo',
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


class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => NewPasswordState();
}

class NewPasswordState extends State<NewPasswordScreen> {

  final TextEditingController _password1ControllerReg = TextEditingController();
  final TextEditingController _password2ControllerReg = TextEditingController();
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
                const Text('Ingresa tu nueva contraseña', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                
                const SizedBox(height: 30,),
                TextField(
                  obscureText: true,
                  controller: _password1ControllerReg,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    labelText: 'Contraseña nueva',
                    suffixIcon: const Icon(
                      Icons.password,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                TextField(
                  obscureText: true,
                  controller: _password2ControllerReg,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    labelText: 'Confirma tu contraseña',
                    suffixIcon: const Icon(
                      Icons.password,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: ()async{
                    if(_password1ControllerReg.text == _password2ControllerReg.text){
                      await changePassword(_password1ControllerReg.text);
                      showMessage(context, 'Contraseña cambiada correctamente', const Color.fromARGB(127, 0, 255, 8));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                    }
                    else{
                      showMessage(context, 'Las contraseñas no coinciden', const Color.fromARGB(126, 255, 0, 0));
                    }
                    
                  }, 
                  child: const Text(
                    'Confirmar contraseña nueva',
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