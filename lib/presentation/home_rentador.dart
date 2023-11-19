import 'package:flutter/material.dart';
import 'package:rental_porch_app/presentation/AgrPor.dart';
import 'package:rental_porch_app/presentation/ElimPor.dart';
import 'package:rental_porch_app/presentation/login_screen.dart';
import 'package:rental_porch_app/presentation/user_page.dart';

class HomeRentador extends StatelessWidget {
  const HomeRentador({super.key});

  void _onContainerPressed(BuildContext context, String text) {
    print("Presionaste el contenedor $text");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(25),
                child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/7429/7429878.png"),
              ),
              const Text("Menu",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              InkWell(
                onTap: () { 
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AgregarPorcheScreen()));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: const Text("Agregar Patio"),
                ),
              ),
              InkWell(
                onTap: () { 
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EliminarPorcheScreen()));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: const Text("Eliminar Patio"),
                ),
              ),
              InkWell(
                onTap: () { 
                  // Aquí va la lógica para "Lista de Reservas"
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: const Text("Lista de Reservas"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage()));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: const Text("Perfil"),
                ),
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () { 
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 2, top: 2),
                  width: double.infinity,
                  color: Colors.black87,
                  alignment: Alignment.center,
                  child: const Text("Cerrar Sesión",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Bienvenido a Rental-Porch - Rentador'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: 5, // Este valor debería ser el número de patios registrados.
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Patio $index'), // Reemplaza por el nombre del patio
                onTap: () {
                  _onContainerPressed(context, 'Patio $index');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
