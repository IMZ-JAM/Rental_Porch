import 'package:flutter/material.dart';
import 'package:rental_porch_app/presentation/home_rentador.dart';
import 'package:rental_porch_app/presentation/home_screen.dart';

class TipoUsuarioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona tu Tipo de Usuario'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeRentador()),
                );
              },
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Puedes ajustar el color del borde
                    width: 2.0, // Puedes ajustar el ancho del borde
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Opcional: para bordes redondeados
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Ink.image(
                        image: const AssetImage('assets/images/Rentador.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(
                          child: Text(
                            'Rentador',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Ink.image(
                        image: const AssetImage('assets/images/Cliente.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(
                          child: Text(
                            'Cliente',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}