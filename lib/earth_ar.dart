import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class Earth_AR extends StatefulWidget {
  const Earth_AR({super.key});

  @override
  State<Earth_AR> createState() => _Earth_ARState();
}

class _Earth_ARState extends State<Earth_AR> {
  ArCoreController? arCoreController;

  void onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    earthMap(arCoreController!);
  }

  earthMap(ArCoreController coreController) async {
    final ByteData EarthMap = await rootBundle.load("assets/earth_map.jpg");

    final material = ArCoreMaterial(
        color: Colors.white, textureBytes: EarthMap.buffer.asUint8List());

    final sphere = ArCoreSphere(
      materials: [material],
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector64.Vector3(0, 0, -1.5),
    );
    arCoreController!.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(onArCoreViewCreated: onArCoreViewCreated),
    );
  }
}
