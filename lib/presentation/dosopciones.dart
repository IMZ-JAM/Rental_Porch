import 'package:flutter/material.dart';
import 'package:rental_porch_app/presentation/home_rentador.dart';
import 'package:rental_porch_app/presentation/home_screen.dart';

class TipoUsuarioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona tu Tipo de Usuario'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200.0, // Ancho personalizado del botón
              height: 80.0, // Altura personalizada del botón
              child: ElevatedButton.icon(
                onPressed: () {
                  
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeRentador()),
              );
                },
                icon: Icon(Icons.home), // Icono representativo para Rentador
                label: Text('Rentador'),
              ),
            ),
            SizedBox(height: 16.0), // Espacio entre los botones
            SizedBox(
              width: 200.0, // Ancho personalizado del botón
              height: 80.0, // Altura personalizada del botón
              child: ElevatedButton.icon(
                onPressed: () {
                  
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
                },
                icon: Icon(Icons.person), // Icono representativo para Cliente
                label: Text('Cliente'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


