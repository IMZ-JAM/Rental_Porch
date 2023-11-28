import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rental_porch_app/presentation/dosopciones.dart';
import 'package:rental_porch_app/presentation/login_screen.dart';
import 'package:rental_porch_app/presentation/user_page.dart';
import 'package:rental_porch_app/services/firebase_service.dart';
import 'package:rental_porch_app/utils/main_interface.dart';

import '../utils/all_porches.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> _favoritePorches = List<bool>.from(AllPorches.favoritePorches);
  // Función que se ejecuta cuando se presiona un contenedor
  void _onContainerPressed(BuildContext context, String text) {
    // Aquí puedes agregar la lógica que desees cuando se presione un contenedor
    
  }
  void changeFavIcon(){
    setState(() {
      _favoritePorches = List<bool>.from(AllPorches.favoritePorches);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(context),
      appBar: AppBar(
          title: const Text('Bienvenido a Rental-Porch')),
      body: 
          Container(
        margin: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: AllPorches.porchesId.length, 
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                title:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${AllPorches.porchesInfo[index]["name"]}'),
                    IconButton(
                      onPressed: ()async{
                        if(!AllPorches.favoritePorches[index]){
                          await addPorchToFavorite(AllPorches.porchesId[index]);
                        }
                        else{
                          await removePorchToFavorite(AllPorches.porchesId[index]);
                        }
                        changeFavIcon();
                      }, 
                      icon: Icon(
                          _favoritePorches[index] ? Icons.favorite:Icons.favorite_outline
                      )
                    )
                ],),
                onTap: (){
                  showClientsPorchInfoDialog(context, 
                  AllPorches.porchesInfo[index]['description'],
                  AllPorches.porchesInfo[index]['area'].toDouble(), 
                  AllPorches.porchesInfo[index]['rentPricePerDay'].toDouble(), 
                  AllPorches.porchesInfo[index]['name'], 
                  AllPorches.porchesId[index], 
                  LatLng(AllPorches.porchesInfo[index]['location'].latitude, 
                  AllPorches.porchesInfo[index]['location'].longitude),
                  AllPorches.porchesInfo[index]['idOwner']
                );
                },
              ),
            );
          },
        ),
      ),
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
            InkWell(
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => TipoUsuarioScreen()));},
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                color: Colors.grey[100],
                child: const Text("Elegir tipo de usuario"),
              ),
            ),
            Expanded(child: Container()),
            const Text("Favoritos",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
              ),
            SizedBox( 
              height: 350,
              child:SingleChildScrollView(
                child: Column(children: [
                  if(AllPorches.favoritePorches.isNotEmpty)
                    for(int i=0;i<AllPorches.porchesId.length;i++)
                      if(AllPorches.favoritePorches[i])
                      InkWell(
                        onTap: () => _onContainerPressed(context, "Patio"),
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: Text(AllPorches.porchesInfo[i]['name']),
                        ),
                      ),
                ]),
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
