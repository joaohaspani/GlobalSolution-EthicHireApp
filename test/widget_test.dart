import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethic_hire/app.dart';

void main() {
  testWidgets('EthicHire - LandingPage e navegação inicial funcionam corretamente',
          (WidgetTester tester) async {
        // Monta o app com ProviderScope (necessário para Riverpod)
        await tester.pumpWidget(
          const ProviderScope(
            child: EthicHireApp(),
          ),
        );

        await tester.pumpAndSettle();

        // ============================
        //  TESTE DA LANDING PAGE
        // ============================

        // Verifica se o nome do app aparece
        expect(find.text('EthicHire'), findsOneWidget);

        // Título explicativo principal
        expect(
          find.text(
            'Conectando pessoas e oportunidades com justiça, transparência e respeito à diversidade.',
          ),
          findsOneWidget,
        );

        // Botão principal
        expect(find.text('Explorar vagas inclusivas'), findsOneWidget);

        // ============================
        //  AÇÃO: Clicar no botão para ir para o app principal
        // ============================

        await tester.tap(find.text('Explorar vagas inclusivas'));
        await tester.pumpAndSettle();

        // ============================
        //  TESTE DO MAIN SHELL
        // ============================

        // Verifica se a tela de vagas cegas foi carregada
        expect(find.text('Vagas cegas recomendadas'), findsOneWidget);

        // Verifica se o bottom navigation possui as 3 abas
        expect(find.text('Vagas cegas'), findsOneWidget);
        expect(find.text('Painel'), findsOneWidget);
        expect(find.text('Perfil'), findsOneWidget);

        // Verifica ícones das abas
        expect(find.byIcon(Icons.work_outline), findsOneWidget);
        expect(find.byIcon(Icons.insights_outlined), findsOneWidget);
        expect(find.byIcon(Icons.person_outline), findsOneWidget);
      });
}
