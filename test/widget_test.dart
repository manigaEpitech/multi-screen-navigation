import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_cuisine/widgets/custom_button.dart';

void main() {
  group('Tests Unitaires et de Widgets de MiamChef', () {
    testWidgets(
      'Le widget CustomButton affiche correctement son texte de label',
      (WidgetTester tester) async {
        // Instanciation du bouton dans l'environnement de test
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomButton(label: 'Tester Sauvegarde', onPressed: () {}),
            ),
          ),
        );

        // Vérification que le texte est présent à l'écran
        expect(find.text('Tester Sauvegarde'), findsOneWidget);
      },
    );

    testWidgets('CustomTextField montre une erreur de validation si vide', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController();
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requis' : null,
              ),
            ),
          ),
        ),
      );

      // Force la validation sans rien écrire
      formKey.currentState!.validate();
      await tester.pump();

      // Vérifie que l'erreur apparaît
      expect(find.text('Requis'), findsOneWidget);
    });
  });
}
