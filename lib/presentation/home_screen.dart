import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rental_porch_app/presentation/dosopciones.dart';
import 'package:rental_porch_app/presentation/login_screen.dart';
import 'package:rental_porch_app/presentation/user_page.dart';
import 'package:rental_porch_app/services/firebase_service.dart';
import 'package:rental_porch_app/utils/main_interface.dart';

import '../classes/all_porches.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<bool> _favoritePorches = List<bool>.from(AllPorches.favoritePorches);
  void changeFavIcon() {
    setState(() {
      _favoritePorches = List<bool>.from(AllPorches.favoritePorches);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(context),
      appBar: AppBar(title: const Text('Bienvenido a Rental-Porch')),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: AllPorches.porchesId.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${AllPorches.porchesInfo[index]["name"]}'),
                    IconButton(
                        onPressed: () async {
                          if (!AllPorches.favoritePorches[index]) {
                            await addPorchToFavorite(
                                AllPorches.porchesId[index]);
                          } else {
                            await removePorchToFavorite(
                                AllPorches.porchesId[index]);
                          }
                          changeFavIcon();
                        },
                        icon: Icon(_favoritePorches[index]
                            ? Icons.favorite
                            : Icons.favorite_outline,
                            color: _favoritePorches[index] 
                            ? Colors.red:
                            Colors.black

                            )
                        )
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text('Precio por día'), Text('\$${AllPorches.porchesInfo[index]['rentPricePerDay']}')]
                ),
                onTap: () {
                  showClientsPorchInfoDialog(
                      context,
                      AllPorches.porchesInfo[index]['description'],
                      AllPorches.porchesInfo[index]['area'].toDouble(),
                      AllPorches.porchesInfo[index]['rentPricePerDay'].toDouble(),
                      AllPorches.porchesInfo[index]['name'],
                      AllPorches.porchesId[index],
                      LatLng(AllPorches.porchesInfo[index]['location'].latitude,AllPorches.porchesInfo[index]['location'].longitude),
                      AllPorches.porchesInfo[index]['idOwner']);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Drawer Menu(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 188, 220, 246),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              const SizedBox(
                height: 37,
              ),
              Container(
                width: 110,
                height: 110,
                margin: const EdgeInsets.all(25),
                child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/7429/7429878.png"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Favoritos",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 250,
                child: SingleChildScrollView(
                  child: Column(children: [
                    if (AllPorches.favoritePorches.isNotEmpty)
                      for (int i = 0; i < AllPorches.porchesId.length; i++)
                        if (AllPorches.favoritePorches[i])
                          InkWell(
                            onTap: () {
                               showClientsPorchInfoDialog(
                                    context,
                                    AllPorches.porchesInfo[i]['description'],
                                    AllPorches.porchesInfo[i]['area'].toDouble(),
                                    AllPorches.porchesInfo[i]['rentPricePerDay'].toDouble(),
                                    AllPorches.porchesInfo[i]['name'],
                                    AllPorches.porchesId[i],
                                    LatLng(AllPorches.porchesInfo[i]['location'].latitude,AllPorches.porchesInfo[i]['location'].longitude),
                                    AllPorches.porchesInfo[i]['idOwner']);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100],
                              ),
                              child: Text(AllPorches.porchesInfo[i]['name']),
                            ),
                          ),
                  ]),
                ),
              ),
              Expanded(child: Container()),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 125, 115, 115),
                  ),
                  Text(
                    "Configuración",
                    style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 22)
                  ),
                ],
              ),
              const SizedBox(height: 3),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserPage()
                      )    
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 3),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: const Text("Perfil"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TipoUsuarioScreen()
                      )
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 3),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: const Text("Elegir Tipo de Usuario"),
                ),
              ),
              const SizedBox(height: 60),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogInScreen()
                      )
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 2, top: 2),
                  width: double.infinity,
                  color: const Color.fromARGB(221, 67, 79, 77),
                  alignment: Alignment.center,
                  child: 
                  const Text(
                    "Cerrar Sesión",
                    style: 
                      TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      )
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
