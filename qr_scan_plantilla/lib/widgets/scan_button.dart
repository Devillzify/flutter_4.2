import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

import '../models/scan_model.dart';
import '../providers/db_provider.dart';

class ScanButton extends StatelessWidget {
  //CENTRAR EN ESTA PAGINA EL VIDEO
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        print(
            'Botó polsat!'); // CAMBIAR ENTRE STRINGS PARA ENSEÑAR FUNCIONAMIENTO

        // String barcodeScanRes = 'geo:39.7260888,2.9113035';
        // String barcodeScanRes = 'https://paucasesnovescifp.cat/';
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#00FFFF', 'Cancel·lar', false, ScanMode.QR);

        ScanModel nouScan = ScanModel(valor: barcodeScanRes);
        scanListProvider.nouScan(barcodeScanRes);
        launchURL(context, nouScan);
      },
    );
  }
}
