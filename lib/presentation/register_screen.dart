// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rental_porch_app/presentation/login_screen.dart';
import 'package:rental_porch_app/services/firebase_service.dart';
import 'package:rental_porch_app/utils/main_Interface.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _emailControllerReg = TextEditingController();
  final TextEditingController _passwordControllerReg = TextEditingController();
  final TextEditingController _nameControllerReg = TextEditingController();
  final TextEditingController _phoneNumberControllerReg = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 200.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Unete a Rental-Porch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
                const SizedBox(height: 20,),
                const Text('REGISTRATE!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                const SizedBox(height: 40,),
                TextField(
                  controller: _nameControllerReg,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: 'Ejemplo: Fernando Martínez',
                    labelText: 'Nombre',
                    suffixIcon: const Icon(
                      Icons.verified_user,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
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
                TextField(
                  controller: _passwordControllerReg,
                  enableInteractiveSelection: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    labelText: 'Contraseña',
                    suffixIcon: const Icon(
                      Icons.password
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                
                const SizedBox(height: 30,),
                TextField(
                  controller: _phoneNumberControllerReg,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    hintText: 'Ejemplo: 8110236545',
                    labelText: 'Teléfono',
                    suffixIcon: const Icon(
                      Icons.phone
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                ElevatedButton(
                  onPressed: () async {
                    List regList = await addUsers(_nameControllerReg.text, _emailControllerReg.text, _passwordControllerReg.text, _phoneNumberControllerReg.text);
                    if(regList[0]){
                      _emailControllerReg.clear();
                      _passwordControllerReg.clear();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                      showMessage(context, regList[1], const Color.fromARGB(127, 0, 255, 8));
                    }else{
                      showMessage(context, regList[1], const Color.fromARGB(126, 255, 0, 0));
                    }
                  }, 
                  child: const Text(
                    'Registrate', 
                    style: TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
                const SizedBox(height: 40,),
                const Text('Ya tienes cuenta?', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));}, child: const Text('Iniciar sesion', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}