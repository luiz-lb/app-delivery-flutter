import 'package:flutter/material.dart';

import '../theme/app_tema.dart';

/// Fundo em degradê laranja com uma estampa de ícones de comida
/// (tipo papel de parede), usado atrás do cartão branco para dar a
/// identidade visual do app.
class FundoComidas extends StatelessWidget {
  const FundoComidas({super.key, required this.child});

  final Widget child;

  static const _icones = [
    Icons.local_pizza,
    Icons.lunch_dining,
    Icons.icecream,
    Icons.ramen_dining,
    Icons.local_cafe,
    Icons.bakery_dining,
    Icons.delivery_dining,
    Icons.cake,
    Icons.set_meal,
    Icons.fastfood,
  ];

  /// Distância entre um ícone e outro da estampa.
  static const _espaco = 76.0;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppCores.laranjaClaro, AppCores.laranjaEscuro],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(child: LayoutBuilder(builder: _estampa)),
          child,
        ],
      ),
    );
  }

  Widget _estampa(BuildContext context, BoxConstraints constraints) {
    final colunas = (constraints.maxWidth / _espaco).ceil() + 1;
    final linhas = (constraints.maxHeight / _espaco).ceil() + 1;

    return Stack(
      children: [
        for (var linha = 0; linha < linhas; linha++)
          for (var coluna = 0; coluna < colunas; coluna++)
            Positioned(
              // Linhas ímpares deslocadas meio espaço, como um ladrilho.
              left: coluna * _espaco + (linha.isOdd ? _espaco / 2 : 0) - 20,
              top: linha * _espaco - 20,
              child: Transform.rotate(
                angle: (linha + coluna).isEven ? -0.3 : 0.3,
                child: Icon(
                  _icones[(linha * 3 + coluna) % _icones.length],
                  size: 30,
                  color: Colors.white.withValues(alpha: 0.14),
                ),
              ),
            ),
      ],
    );
  }
}
