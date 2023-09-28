import 'package:flutter/material.dart';

class EliminarPorcheScreen extends StatefulWidget {
  @override
  _EliminarPorcheScreenState createState() => _EliminarPorcheScreenState();
}

class _EliminarPorcheScreenState extends State<EliminarPorcheScreen> {
  final _formKey = GlobalKey<FormState>();
  String? nombrePorche; // Cambiamos a String nullable
  double? precioPorche; // Cambiamos a double nullable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminar Porche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre del Porche'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un nombre';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    nombrePorche = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Precio por Hora'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un precio';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    precioPorche = double.tryParse(value);
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ubicacion'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una ubicacion';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    nombrePorche = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aquí puedes guardar la información del porche en tu base de datos o hacer lo que necesites.
                    // Puedes acceder a 'nombrePorche' y 'precioPorche' para obtener los valores ingresados.
                    // Luego, redirige al vendedor a la página principal u otra página según tu flujo de la aplicación.
                    // Ejemplo: Navigator.of(context).pop();
                    //Aqui se guardara la informacion en la base de datos
                  }
                },
                child: Text('Eliminar Porche'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
