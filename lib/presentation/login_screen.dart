// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rental_porch_app/presentation/register_screen.dart';
import 'package:rental_porch_app/presentation/dosopciones.dart';
import 'package:rental_porch_app/services/firebase_service.dart';
import 'package:rental_porch_app/utils/main_interface.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailControllerLogin = TextEditingController();
  final TextEditingController _passwordControllerLogin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white , // Cambia a tu color de fondo deseado
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 120.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.all(10),
                  child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/7429/7429878.png"),
                ),
                const Text('Bienvenidos a Rental-Porch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27 ),),
                const SizedBox(height: 20,),
                const Text('Inicio de sesion', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                const SizedBox(height: 20,),
                TextField(

                  controller: _emailControllerLogin,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Ejemplo: porch@gmail.com',
                    labelText: 'Email',
                    suffixIcon: const Icon(
                      Icons.alternate_email,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    filled: true, // Hace que el fondo del TextField se llene de color
                    fillColor: Colors.white, // Cambia a tu color deseado
                  ),
                ),
                const SizedBox(height: 30,),
                TextField(
                  controller: _passwordControllerLogin,
                  enableInteractiveSelection: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Contraseña',
                    suffixIcon: const Icon(
                      Icons.password
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    filled: true, // Hace que el fondo del TextField se llene de color
                    fillColor: Colors.white, // Cambia a tu color deseado
                  ),
                ),
                const SizedBox(height: 40,),
                ElevatedButton(
                  onPressed: () async {
                    List loginList = await getUsers(_emailControllerLogin.text, _passwordControllerLogin.text);
                    if(loginList[0]){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TipoUsuarioScreen()));  
                      _emailControllerLogin.clear();
                      _passwordControllerLogin.clear();
                    }
                    else{
                      showMessage(context, loginList[1], const Color.fromARGB(184, 255, 0, 0));
                    }
                    }, 
                    child: const Text('Iniciar sesion', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue ),)),
                const SizedBox(height: 40,),
                const Text('Aun no tienes cuenta?', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));}, child: const Text('Registrate', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,  color: Colors.lightBlue ),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

