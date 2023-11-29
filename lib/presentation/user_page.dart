import 'package:flutter/material.dart';

import '../classes/user.dart';
import '../utils/main_interface.dart';
import '../services/firebase_service.dart';

// ignore: camel_case_types
class UserPage extends StatefulWidget{
  const UserPage({super.key});
  @override
  State<UserPage> createState() => _userControllerState();
}

// ignore: camel_case_types
class _userControllerState extends State<UserPage>{
    final TextEditingController _userControllerName = TextEditingController();
    final TextEditingController _userControllerPassword = TextEditingController();
    final TextEditingController _userControllerEmail = TextEditingController();
    final TextEditingController _userControllerPhoneNumber = TextEditingController();
    String userPagePassword = 'Contraseña';
    void _saveChanges(){
      setState(() {
        updateUser(_userControllerName.text,_userControllerEmail.text, _userControllerPassword.text, _userControllerPhoneNumber.text);  
      });
      showMessage(context, 'Cambios guardados', const Color.fromARGB(200, 59, 255, 163));
    }
    void _passwordVisible(){
      setState(() {
        if(identical(userPagePassword, 'Contraseña')){
          userPagePassword = User.info['password'];
        }
        else{
          userPagePassword = 'Contraseña';
        }
      });
    }

    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          // ignore: prefer_interpolation_to_compose_strings
          title: Center(child: Text('Cuenta de '+User.info['name'], )),
        ),
        body: SingleChildScrollView(
          child: MyContainer(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sizeEspacio(),
                MyTextInputEnabled(label: 'ID : ${User.id}', inputIcon: const Icon(Icons.fingerprint, color: Colors.black)),
                _sizeEspacio(),
                const Divider(
                  color: Colors.black,
                  thickness: 2.0,
                ),
                MyTextInput(inputController: _userControllerName, label: User.info['name'], inputIcon: const Icon(Icons.person)),
                _sizeEspacio(),
                 MyTextInput(inputController: _userControllerEmail, label: User.info['email'], inputIcon: const Icon(Icons.email)),
                _sizeEspacio(),
                MyTextInput(inputController: _userControllerPhoneNumber, label: User.info['phoneNumber'], inputIcon: const Icon(Icons.phone)),
                _sizeEspacio(),
                Row(children: [
                   MyTextInput(inputController: _userControllerPassword, label: userPagePassword.toString(),inputIcon: const Icon(Icons.password)),
                   MyPasswordButton(press: _passwordVisible),
                ],),
                _sizeEspacio(),
                Center(child: MyButton(
                  lblText: const Text(
                    "Guardar cambios",
                     style: TextStyle(
                      fontFamily: 'PlaypenSans',

                     )
                  ), 
                  press: () => {_saveChanges()}
                ),)
              ],
            ),
          )
        ),
        )
      );
    }
  }

Widget _sizeEspacio(){
  return const SizedBox(
    height: 30,
  );
}



class MyTextInputEnabled extends StatelessWidget {
  const MyTextInputEnabled({super.key,required this.label, required this.inputIcon});
  final String label;
  final Icon inputIcon;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        enabled: false,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          prefixIcon: inputIcon,
          labelStyle: const TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
          labelText: label,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyTextInput extends StatelessWidget {
  MyTextInput({super.key,required this.inputController, required this.label, required this.inputIcon});
  TextEditingController inputController;
  String label;
  Icon inputIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: inputController,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          prefixIcon: inputIcon,
          labelStyle: const TextStyle(fontSize: 18, color: Colors.black87),
          labelText: label,
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.lblText, required this.press});
  final Text lblText;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press, 
      style: ElevatedButton.styleFrom(                
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      child: lblText,

    );
  }
}

class MyPasswordButton extends StatelessWidget {
  const MyPasswordButton({super.key, required this.press});
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.remove_red_eye, color: Theme.of(context).primaryColor,), 
      onPressed: press
    );
  }
}
class MyContainer extends StatelessWidget {
  const MyContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      margin: const EdgeInsets.symmetric(),
      decoration: const BoxDecoration(
            color: Color.fromARGB(107, 247, 251, 252)
        ),
      child: child,
    );
  }
}
