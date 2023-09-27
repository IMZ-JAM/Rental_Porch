import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


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
                          child: Image.network("https://w7.pngwing.com/pngs/194/804/png-transparent-favorite-star-favorites-favourite-multimedia-multimedia-icon.png"),

                        ),

                        const Text("Favoritos", style: TextStyle(fontWeight:FontWeight.bold, fontSize: 20 ),),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: const Text("Fav1"),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: const Text("Fav2"),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: const Text("Fav3"),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 30, top: 2),
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: const Text("Fav3"),
                        ),
                        const Text("Menu", style: TextStyle(fontWeight:FontWeight.bold, fontSize: 20 ),),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(15),
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: const Text("Perfil"),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          padding: const EdgeInsets.all(15),
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: const Text("Ajustes"),
                        ),
                        Container(

                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(bottom: 30, top:2),
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: const Text("Cerrar secion"),
                        ),
                      ],
                    ),
                  ),
                ),



              appBar: AppBar(title: const Text('Bienvenido a Rental-Porch'),),
            );
          }


}