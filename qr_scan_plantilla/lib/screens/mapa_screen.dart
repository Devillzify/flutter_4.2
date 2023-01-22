import 'dart:async';

import 'package:flutter/material.dart';
import '../models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaScreen extends StatefulWidget {
  //ventana del mapa
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  bool cambio = true; // booleano usado para cambiar el tipo de mapa
  late GoogleMapController
      inicial; // controller google que usamos para recibir el valor de la primera vez que cargamos el mapa
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    MapType cambiar() {
      // usamos el booleano de arriba para cambiar el tipo de mapa
      if (cambio) {
        return MapType.normal;
      } else {
        return MapType.hybrid;
      }
    }

    final ScanModel scan =
        ModalRoute.of(context)?.settings.arguments as ScanModel;

    final CameraPosition _puntInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
    );

    Set<Marker> markers = new Set<Marker>();
    markers
        .add(new Marker(markerId: MarkerId('id1'), position: scan.getLatLng()));
    return Scaffold(
      appBar: AppBar(
        //añadimos el appbar para volver atras y poner el boton de centrar
        actions: [
          IconButton(
              onPressed: () {
                inicial.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: _puntInicial.target, zoom: 17)));
              },
              icon: Icon(Icons.home))
        ],
        title: Text("Mapa"),
      ),
      body: GoogleMap(
        markers: markers,
        mapType: cambiar(),
        initialCameraPosition: _puntInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          inicial = controller; // aqui declaramos que nuestro controller
          //sea igual que el otro y no se modifica mas, de tal manera que se queda con las coordenadas del principio
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsetsDirectional.only(end: 40),
        child: FloatingActionButton(
          onPressed: () {
            // cambiamos el valor del booleano y actualizamos
            if (cambio) {
              cambio = false;
            } else {
              cambio = true;
            }
            setState(() {});
          },
          child: Icon(Icons.map_rounded),
        ),
      ),
    );
  }
}
