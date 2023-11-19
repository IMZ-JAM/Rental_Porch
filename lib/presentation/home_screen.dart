import 'package:flutter/material.dart';
import 'package:rental_porch_app/presentation/login_screen.dart';
import 'package:rental_porch_app/presentation/user_page.dart';
import 'package:rental_porch_app/presentation/AgrPor.dart';
import 'package:rental_porch_app/presentation/ElimPor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Función que se ejecuta cuando se presiona un contenedor
  void _onContainerPressed(BuildContext context, String text) {
    // Aquí puedes agregar la lógica que desees cuando se presione un contenedor
    print("Presionaste el contenedor $text");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(context),
      appBar: AppBar(
          title: const Text('Bienvenido a Rental-Porch')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://img.freepik.com/vector-premium/mapa-ciudad-cualquier-tipo-informacion-grafica-digital-publicacion-impresa-mapa-gps_403715-37.jpg?w=2000"),
            fit: BoxFit.cover
          )
        ),
      ),
      floatingActionButton: const Buttom_zoom(),

      );

  }

  Drawer Menu(BuildContext context) {
    return Drawer(
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
            
            const SizedBox(height: 10,),
            const Text("Favoritos",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            InkWell(
              onTap: () => _onContainerPressed(context, "Patio"),
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                color: Colors.grey[100],
                child: const Text("Patio"),
              ),
            ),
            InkWell(
              onTap: () => _onContainerPressed(context, "Patio1"),
              child: Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                color: Colors.grey[100],
                child: const Text("Patio1"),
              ),
            ),
            InkWell(
              onTap: () => _onContainerPressed(context, "Patio2"),
              child: Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                color: Colors.grey[100],
                child: const Text("Patio2"),
              ),
            ),
            InkWell(
              onTap: () => _onContainerPressed(context, "Patio3"),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 30, top: 2),
                width: double.infinity,
                color: Colors.grey[100],
                child: const Text("Patio3"),
              ),
            ),
            const Text("Menu",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            InkWell(
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage()));},
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                color: Colors.grey[100],
                child: const Text("Perfil"),
              ),
            ),
            Expanded(child: Container()),
            InkWell(
              onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));},
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
    );
  }
}

class Buttom_zoom extends StatelessWidget {
  const Buttom_zoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AgregarPorcheScreen()),
            );
          },
          child: const Icon(Icons.zoom_in), 
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
            )
          ),
        ),
        const SizedBox(height: 16.0), // Espacio entre los botones
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EliminarPorcheScreen()),
            );
          },
          child: const Icon(Icons.zoom_out), 
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
            )
          ),
        ),
      ],
    );
  }
}
