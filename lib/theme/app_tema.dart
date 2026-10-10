import 'package:flutter/material.dart';

/// Identidade da marca: troque aqui o nome e o slogan do app.
class AppMarca {
  AppMarca._();

  static const nome = 'Fominha';
  static const slogan = 'Sua fome, nossa missão.';
  static const logo = 'assets/images/logo_fominha.svg';
}

/// Paleta de cores do Fominha.
class AppCores {
  AppCores._();

  static const laranja = Color(0xFFFF6A2B);
  static const laranjaClaro = Color(0xFFFF8A3D);
  static const laranjaEscuro = Color(0xFFE8491D);
  static const texto = Color(0xFF2D2A26);
  static const textoSecundario = Color(0xFF7A736E);
  static const campo = Color(0xFFFAF7F5);
  static const borda = Color(0xFFE9E2DD);
  static const erro = Color(0xFFD93025);
}

/// Tema do app: campos, botões e mensagens já saem com a cara da marca.
class AppTema {
  AppTema._();

  static ThemeData get claro {
    final bordaCampo = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppCores.borda),
    );
    final formaBotao = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );

    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppCores.laranja,
        primary: AppCores.laranja,
        error: AppCores.erro,
      ),
    );
    // Parte do estilo de botão do tema para manter a mesma fonte do app.
    final textoBotao = base.textTheme.labelLarge!;

    return base.copyWith(
      scaffoldBackgroundColor: AppCores.laranja,
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: AppCores.campo,
        hintStyle: const TextStyle(
          color: AppCores.textoSecundario,
          fontSize: 14,
        ),
        prefixIconColor: AppCores.textoSecundario,
        suffixIconColor: AppCores.textoSecundario,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: bordaCampo,
        enabledBorder: bordaCampo,
        focusedBorder: bordaCampo.copyWith(
          borderSide: const BorderSide(color: AppCores.laranja, width: 1.6),
        ),
        errorBorder: bordaCampo.copyWith(
          borderSide: const BorderSide(color: AppCores.erro),
        ),
        focusedErrorBorder: bordaCampo.copyWith(
          borderSide: const BorderSide(color: AppCores.erro, width: 1.6),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppCores.laranja,
          foregroundColor: Colors.white,
          // Enquanto "carrega", o botão fica desabilitado mas mantém a cor.
          disabledBackgroundColor: AppCores.laranja.withValues(alpha: 0.75),
          disabledForegroundColor: Colors.white,
          minimumSize: const Size.fromHeight(54),
          shape: formaBotao,
          textStyle: textoBotao.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppCores.texto,
          minimumSize: const Size.fromHeight(54),
          side: const BorderSide(color: AppCores.borda, width: 1.4),
          shape: formaBotao,
          textStyle: textoBotao.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppCores.laranjaEscuro,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          textStyle: textoBotao.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppCores.texto,
      ),
    );
  }
}
