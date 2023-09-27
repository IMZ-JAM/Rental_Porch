import 'package:flutter/material.dart';
import 'package:rental_porch_app/presentation/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String _name = '';
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
                const Text('Unete a Rental-Porch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
                const SizedBox(height: 20,),
                const Text('REGISTRATE!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                const SizedBox(height: 40,),
                TextField(
                  enableInteractiveSelection: false,
                  autofocus: true,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: 'Fernando Martínez',
                    labelText: 'Nombre',
                    suffixIcon: const Icon(
                      Icons.verified_user,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  onSubmitted: (valor) {
                    _name = valor;
                    print('El email es $_name');
                  },
                ),
                const SizedBox(height: 30,),
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
                ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));}, child: const Text('Registrate', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
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