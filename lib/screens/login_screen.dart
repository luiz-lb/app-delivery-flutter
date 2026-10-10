import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_tema.dart';
import '../widgets/fundo_comidas.dart';
import '../widgets/logo_marca.dart';

/// 2ª entrega - Tela de login
///
/// FundoComidas
///  └─ SafeArea
///      └─ Center
///          └─ SingleChildScrollView
///              └─ Container (cartão branco)
///                  └─ Form
///                      └─ Column
///                          ├─ LogoMarca
///                          ├─ Text ("Entrar")
///                          ├─ Text ("Acesse sua conta para continuar.")
///                          ├─ _Rotulo + TextFormField (e-mail)
///                          ├─ _Rotulo + TextFormField (senha)
///                          ├─ TextButton ("Esqueci minha senha")
///                          ├─ FilledButton ("Entrar")
///                          ├─ _DivisorOu
///                          ├─ OutlinedButton ("Continuar com Google")
///                          └─ Wrap ("Não tem uma conta? Criar conta")
///
/// Apenas interface: não há backend, os botões só mostram uma mensagem.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _senhaVisivel = false;
  bool _carregando = false;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _mostrarMensagem(String texto, {IconData icone = Icons.info_outline}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icone, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(child: Text(texto)),
            ],
          ),
        ),
      );
  }

  Future<void> _entrar() async {
    if (_carregando) return;
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    // Simula o tempo de uma requisição (não há backend).
    setState(() => _carregando = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _carregando = false);

    _mostrarMensagem(
      'Bem-vindo ao ${AppMarca.nome}! (demonstração, sem backend)',
      icone: Icons.check_circle_outline,
    );
  }

  static String? _validarEmail(String? valor) {
    final email = valor?.trim() ?? '';
    if (email.isEmpty) return 'Informe seu e-mail.';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'E-mail inválido.';
    }
    return null;
  }

  static String? _validarSenha(String? valor) {
    if (valor == null || valor.isEmpty) return 'Informe sua senha.';
    if (valor.length < 6) return 'A senha deve ter pelo menos 6 caracteres.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FundoComidas(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  children: [
                    _cartao(),
                    const SizedBox(height: 16),
                    Text(
                      '© 2026 ${AppMarca.nome} · ${AppMarca.slogan}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cartao() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: LogoMarca()),
            const SizedBox(height: 20),
            const Text(
              'Entrar',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: AppCores.texto,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Acesse sua conta para continuar.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppCores.textoSecundario),
            ),
            const SizedBox(height: 28),
            const _Rotulo('E-mail'),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              validator: _validarEmail,
              decoration: const InputDecoration(
                hintText: 'Digite seu e-mail',
                prefixIcon: Icon(Icons.mail_outline_rounded),
              ),
            ),
            const SizedBox(height: 16),
            const _Rotulo('Senha'),
            TextFormField(
              controller: _senhaController,
              obscureText: !_senhaVisivel,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              onFieldSubmitted: (_) => _entrar(),
              validator: _validarSenha,
              decoration: InputDecoration(
                hintText: 'Digite sua senha',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  tooltip: _senhaVisivel ? 'Ocultar senha' : 'Mostrar senha',
                  icon: Icon(
                    _senhaVisivel
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () =>
                      setState(() => _senhaVisivel = !_senhaVisivel),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _mostrarMensagem(
                  'Recuperação de senha disponível em breve.',
                  icone: Icons.lock_reset,
                ),
                child: const Text('Esqueci minha senha'),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: _carregando ? null : _entrar,
              child: _carregando
                  ? const SizedBox.square(
                      dimension: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.6,
                        color: Colors.white,
                      ),
                    )
                  : const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Entrar'),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
            ),
            const SizedBox(height: 20),
            const _DivisorOu(),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () => _mostrarMensagem(
                'Login com Google é apenas ilustrativo nesta versão.',
              ),
              icon: SvgPicture.asset(
                'assets/images/google_g.svg',
                width: 20,
                height: 20,
              ),
              label: const Text('Continuar com Google'),
            ),
            const SizedBox(height: 12),
            // Wrap em vez de Row: em telas estreitas o link desce de linha.
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  'Não tem uma conta?',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppCores.textoSecundario,
                  ),
                ),
                TextButton(
                  onPressed: () => _mostrarMensagem(
                    'Cadastro disponível em breve.',
                    icone: Icons.person_add_alt_1,
                  ),
                  child: const Text('Criar conta'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Rótulo acima de cada campo ("E-mail", "Senha").
class _Rotulo extends StatelessWidget {
  const _Rotulo(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppCores.texto,
        ),
      ),
    );
  }
}

/// Linha divisória com o "ou" no meio.
class _DivisorOu extends StatelessWidget {
  const _DivisorOu();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppCores.borda)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'ou',
            style: TextStyle(fontSize: 13, color: AppCores.textoSecundario),
          ),
        ),
        Expanded(child: Divider(color: AppCores.borda)),
      ],
    );
  }
}
