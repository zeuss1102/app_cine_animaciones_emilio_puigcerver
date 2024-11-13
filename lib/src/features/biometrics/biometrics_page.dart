import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_movie_ticket/src/core/constants/constants.dart';

class BiometricsPage extends StatelessWidget {
  const BiometricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Lottie.asset(
          faceIDLottie,
          width: 250,
          height: 250,
          frameRate: FrameRate.max,
          repeat: false,
          onLoaded: (composition) {
            // Puedes añadir lógica adicional al cargar la animación si es necesario.
          },
        ),
      ),
    );
  }
}

