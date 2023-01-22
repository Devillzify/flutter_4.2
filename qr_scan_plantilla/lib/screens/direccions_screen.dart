import 'package:flutter/material.dart';
import 'package:qr_scan/widgets/scan_tiles.dart';

class DireccionsScreen extends StatelessWidget {
  // nada que comentar
  const DireccionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipus: 'http');
  }
}
