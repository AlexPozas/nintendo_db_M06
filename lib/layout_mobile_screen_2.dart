import 'package:flutter/material.dart';
import 'package:nintendo_db/layout_consola.dart';
import 'package:nintendo_db/layout_joc.dart';
import 'package:provider/provider.dart';
import 'layout_personatge.dart';
import 'layout_consola.dart';
import 'app_data.dart';

class LayoutMobileScreen2 extends StatefulWidget {
  final String seccio;
  final int index;

  const LayoutMobileScreen2(
      {Key? key, required this.seccio, required this.index})
      : super(key: key);
  @override
  State<LayoutMobileScreen2> createState() => _StateLayoutMobileScreen2();
}

class _StateLayoutMobileScreen2 extends State<LayoutMobileScreen2> {
  _StateLayoutMobileScreen2();
  Widget _setBody(BuildContext context, dynamic itemData) {
    switch (widget.seccio) {
      case 'Personatges':
        return LayoutPersonatge(itemData: itemData);
      case 'Consoles':
        return LayoutConsola(itemData: itemData);
      case 'Jocs':
        return LayoutJoc(itemData: itemData);
    }
    return Text('Unknown layout: ${widget.seccio}');
  }

  @override
  Widget build(BuildContext context) {
// Referència a l’objecte que gestiona les dades de l’aplicació
    AppData appData = Provider.of<AppData>(context);
    dynamic itemData = appData.getItemData(widget.seccio, widget.index);
// Si no tenim les dades, carregar-les i mostrar un 'loading'
    if (!appData.dataReady(widget.seccio)) {
      appData.load(widget.seccio);
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue.shade200,
            title: Text(itemData['nom']),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: _setBody(context, itemData));
    }
  }
}
