// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class UserCliente extends StatefulWidget{
  const UserCliente({super.key});
  @override
  State<UserCliente> createState() => _UserClienteState();
}

class _UserClienteState extends State<UserCliente>{
    final TextEditingController _userName = TextEditingController();
    final TextEditingController _userPassword = TextEditingController();
    final TextEditingController _userPhoneNumber = TextEditingController();
    final TextEditingController _userEmail = TextEditingController();
    String userName = 'Pablo Gomez', userPassword = 'Contraseña', userPhoneNumber = '8180371234', userEmail = 'jg0909@gmail.com';
    String realPassword = 'PPPP';//Se obtendria de la base de datos
    void _saveChanges(){
      //Actualizarla con la base de datos y cargar datos nuevos
    }
     void _passwordVisible(){
      setState(() {
        if(identical(userPassword, 'Contraseña'))
        {
          userPassword = realPassword;
        }
        else
        {
          userPassword = 'Contraseña';
        }
      });
    }
    @override
    Widget build(BuildContext context){
      return Scaffold(
        
        appBar: AppBar(
          title: const Center(child: Text('Cliente : Pablo')),
          backgroundColor: const Color.fromARGB(255, 9, 181, 181),
        ),
        
        body: SingleChildScrollView(
          child: MyContainer(
            child: Column(
              children: [
                const Stack(//sobrepone los sig widgets
                  children: [MyAppContainer()],
                ),
                _sizeEspacio(),
                MyTextInput(inputController: _userName, label: userName, inputIcon: const Icon(Icons.person), passwordQuestion: false,),
                _sizeEspacio(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                   MyTextInput(inputController: _userPassword, label: userPassword.toString(),inputIcon: const Icon(Icons.password),passwordQuestion: true),
                   MyPasswordButton(press: _passwordVisible),
                ],),     
                _sizeEspacio(),
                MyTextInput(inputController: _userPhoneNumber, label: userPhoneNumber,inputIcon: const Icon(Icons.phone),passwordQuestion: false),
                _sizeEspacio(),
                MyTextInput(inputController: _userEmail, label: userEmail,inputIcon: const Icon(Icons.email),passwordQuestion: false),
                _sizeEspacio(),
               
                MyButton(
                  lblText: const Text("Cambiar informacion"), 
                  press: () => _saveChanges()
                ),
                _sizeEspacio(),
              ],
            ),
          )
        ),
      );
    }
  }

Widget _sizeEspacio(){
  return const SizedBox(
    height: 30,
  );
}


class MyTextInput extends StatelessWidget {
  const MyTextInput({super.key, required this.inputController, required this.label, required this.inputIcon, required this.passwordQuestion});
  final TextEditingController inputController;
  final String label;
  final bool passwordQuestion;
  final Icon inputIcon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.only(left: 70, right: 70),
        child: TextFormField(
          controller: inputController,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            prefixIcon: inputIcon,
            labelStyle: const TextStyle(fontSize: 18, color: Colors.black87),
            labelText: label,
            
            ),
            obscureText: passwordQuestion
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  MyText({super.key, required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text, 
      style: const TextStyle(
        color: Colors.black87, fontSize: 17, fontWeight: FontWeight.bold,
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
        backgroundColor: const Color.fromARGB(255, 9, 181, 181),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        textStyle: const TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500
        )

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
    return ElevatedButton.icon(
      onPressed: press, 
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        textStyle: const TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500
        ),

      ),
      icon : const Icon(Icons.visibility), 
      label: const Text(''),


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
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(31, 255, 255, 255).withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40), bottomLeft: Radius.circular(40),

        ), 

      ),
      child: child,
    );
  }
}

class MyAppContainer extends StatelessWidget {
  const MyAppContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}
