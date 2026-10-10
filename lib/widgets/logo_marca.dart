import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_tema.dart';

/// Logo + nome da marca (ocupa o lugar do quadrado "Marca" do esboço).
class LogoMarca extends StatelessWidget {
  const LogoMarca({super.key, this.tamanho = 88});

  final double tamanho;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(tamanho * 0.25),
            boxShadow: [
              BoxShadow(
                color: AppCores.laranja.withValues(alpha: 0.35),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: SvgPicture.asset(
            AppMarca.logo,
            width: tamanho,
            height: tamanho,
            semanticsLabel: 'Logo ${AppMarca.nome}',
          ),
        ),
        const SizedBox(height: 10),
        Text(
          AppMarca.nome.toLowerCase(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            color: AppCores.laranjaEscuro,
          ),
        ),
      ],
    );
  }
}
