import 'package:flutter/material.dart';

class HomeRentador extends StatefulWidget {
  const HomeRentador({Key? key}) : super(key: key);

  @override
  _HomeRentadorState createState() => _HomeRentadorState();
}

class _HomeRentadorState extends State<HomeRentador> {
  void _navigateToAddPatio() {
    // Navegar a la pantalla para agregar un patio.
    print('Navegando para agregar un patio...');
  }
  void _navigateToRemovePatio() {
    // Navegar a la pantalla para eliminar un patio.
    print('Navegando para eliminar un patio...');
  }

  void _navigateToReservationsCalendar() {
    // Navegar a la pantalla del calendario de reservas.
    print('Navegando al calendario de reservas...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Inicio - Rentador')),
        backgroundColor: const Color.fromARGB(255, 9, 181, 181),
      ),
      body: SingleChildScrollView(
        child: MyContainer(
          child: Column(
            children: [
              // Los widgets en la Stack pueden ser reemplazados o modificados según tu diseño preferido.
              const Stack(
                children: [MyAppContainer()],
              ),
              _sizeEspacio(),
              MyButton(
                lblText: const Text('Agregar Patio'),
                press: _navigateToAddPatio,
              ),
              _sizeEspacio(),
              MyButton(
                lblText: const Text('Eliminar Patio'),
                press: _navigateToRemovePatio,
              ),
              _sizeEspacio(),
              MyButton(
                lblText: const Text('Ver Calendario de Reservas'),
                press: _navigateToReservationsCalendar,
              ),
              _sizeEspacio(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sizeEspacio() {
    return const SizedBox(height: 30);
  }
}

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.lblText, required this.press})
      : super(key: key);
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
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      child: lblText,
    );
  }
}

class MyContainer extends StatelessWidget {
  const MyContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      margin: const EdgeInsets.symmetric(),
      decoration: BoxDecoration(
        color: const Color.fromARGB(31, 255, 255, 255).withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}

class MyAppContainer extends StatelessWidget {
  const MyAppContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}