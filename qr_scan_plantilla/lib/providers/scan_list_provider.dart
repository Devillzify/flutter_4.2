import 'package:flutter/cupertino.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipusSeleccionat = 'http';

  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor);
    final id = await DBProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if (nouScan.tipus == tipusSeleccionat) {
      this.scans.add(nouScan);
      notifyListeners();
    }
    return nouScan;
  }

  carregaScans() async {
    final scans =
        await DBProvider.db.getAllScans(); // enseñar todos. No utilizado
    this.scans = [...scans];
    notifyListeners();
  }

  carregarScansPerTipus(String tipus) async {
    //recibe el tipo de informacion
    final scans = await DBProvider.db.getScanByTipus(tipus);
    this.scans = [...scans];
    notifyListeners();
  }

  esborraTots() async {
    // aqui hacemos que scans sea una lista vacia para que desaparezcan todos.
    final scans = await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  esborraPerId(int id) async {
    // borramos usando la id
    final scans = await DBProvider.db.deleteById(id);
    this.scans.removeAt(scans);
    notifyListeners();
  }
}
