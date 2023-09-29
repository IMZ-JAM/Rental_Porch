import 'package:flutter/material.dart';
import 'package:rental_porch_app/presentation/register_screen.dart';
import 'package:rental_porch_app/presentation/dosopciones.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  String _email = '';
  String _password = '';

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
                const Text('Bienvenidos a Rental-Porch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                const SizedBox(height: 20,),
                const Text('Inicio de sesion', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                const SizedBox(height: 40,),
                TextField(
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
                  onSubmitted: (valor) {
                    _email = valor;
                    print('El email es $_email');
                  },
                ),
                const SizedBox(height: 30,),
                TextField(
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
                  ),
                  onSubmitted: (valor) {
                    _password = valor;
                    print('La contraseña es $_password');
                  },
                ),
                const SizedBox(height: 40,),
                ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => TipoUsuarioScreen()));}, child: const Text('Iniciar sesion', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
                const SizedBox(height: 40,),
                const Text('Aun no tienes cuenta?', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));}, child: const Text('Registrate', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
