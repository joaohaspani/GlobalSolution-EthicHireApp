import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.primary.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.handshake,
                      size: 32,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'EthicHire',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Recrutamento ético e inclusivo',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Conectando pessoas e oportunidades com justiça, '
                'transparência e respeito à diversidade.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'O EthicHire foi criado para apoiar quem busca emprego em um mercado '
                'cada vez mais competitivo, garantindo processos seletivos mais humanos '
                'e livres de vieses. Aqui, o foco está nas suas competências, '
                'na sua trajetória e no seu potencial — não em estereótipos.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              const Text(
                'Com vagas cegas, match ético e métricas de inclusão, '
                'ajudamos empresas a selecionarem de forma responsável e candidatos '
                'a terem mais visibilidade e igualdade de oportunidade.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.explore_outlined),
                      label: const Text('Explorar vagas inclusivas'),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/main');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/main');
                },
                child: const Text('Já conheço o EthicHire, ir direto para o app'),
              ),
              const Spacer(),
              const Text(
                'EthicHire acredita em processos seletivos mais justos, '
                'valorizando a diversidade e o desenvolvimento das pessoas.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
