import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_delivery/main.dart';

void main() {
  final botaoEntrar = find.widgetWithText(FilledButton, 'Entrar');

  Future<void> tocar(WidgetTester tester, Finder alvo) async {
    await tester.ensureVisible(alvo);
    await tester.pumpAndSettle();
    await tester.tap(alvo);
  }

  testWidgets('mostra os elementos do esboço', (tester) async {
    await tester.pumpWidget(const FominhaApp());

    expect(find.text('Entrar'), findsNWidgets(2)); // título + botão
    expect(find.text('Acesse sua conta para continuar.'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('Esqueci minha senha'), findsOneWidget);
    expect(find.text('ou'), findsOneWidget);
    expect(find.text('Continuar com Google'), findsOneWidget);
    expect(find.text('Criar conta'), findsOneWidget);
  });

  testWidgets('valida os campos vazios ao tocar em Entrar', (tester) async {
    await tester.pumpWidget(const FominhaApp());

    await tocar(tester, botaoEntrar);
    await tester.pump();

    expect(find.text('Informe seu e-mail.'), findsOneWidget);
    expect(find.text('Informe sua senha.'), findsOneWidget);
  });

  testWidgets('login válido mostra mensagem de demonstração', (tester) async {
    await tester.pumpWidget(const FominhaApp());

    await tester.enterText(find.byType(TextFormField).at(0), 'eu@fominha.com');
    await tester.enterText(find.byType(TextFormField).at(1), '123456');
    await tocar(tester, botaoEntrar);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pump();
    expect(find.textContaining('Bem-vindo ao Fominha!'), findsOneWidget);
  });
}
