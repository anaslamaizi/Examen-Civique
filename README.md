# Examen Civique FR

Application Flutter Android-first pour préparer l'examen civique français, hors ligne.

## Modèle Free/Premium Android

L’app reste gratuite à l’installation, mais certaines fonctionnalités sont préparées pour le modèle Premium, aligné avec l’app web.

### Gratuit
- 1 quiz gratuit par jour.
- Accès aux premiers thèmes gratuits.
- Accès aux premières fiches de révision gratuites.
- Progression locale : favoris, erreurs, fiches lues.

### Premium
- Quiz illimités.
- Tous les thèmes.
- Créer mon quiz.
- Revoir mes erreurs.
- Points faibles / erreurs & favoris.
- Examens blancs complets.
- Toutes les fiches de révision.

### Statut Premium
Le modèle mobile prévoit les champs :
- `isPremium`
- `premiumUntil`
- `plan`
- `subscriptionSource` : `web` ou `android`

Le backend doit rester la source de vérité quand la synchronisation web/mobile sera connectée.

### Paiement Android
Une couche `PurchaseService` prépare l’intégration Google Play Billing, sans activer de paiement réel pour l’instant.
À connecter ensuite avec :
- produits Play Console (`premium_7_days`, `premium_monthly`)
- validation serveur du purchase token
- restauration des achats
- synchronisation backend du statut Premium

## Propositions de nom final
1. Civique Flash France
2. Réussite Examen Civique
3. Civique 2025 France

## Sous-titre store
Préparation rapide, quiz officiels et révision intelligente hors ligne.

## Description courte Play Store
Révisez l’examen civique français avec des quiz par thème, correction instantanée, mode test complet et flashcards offline.

## Description longue Play Store
Examen Civique FR est l’app simple et efficace pour préparer l’examen civique français.

### Pourquoi installer l’app
- 100% hors ligne : révisez partout, même sans connexion.
- Quiz par thème : travaillez vos points faibles.
- Test complet : entraînez-vous en conditions proches de l’examen.
- Correction instantanée ou finale : choisissez votre méthode.
- Flashcards : mémorisez rapidement les notions clés.
- Historique local : erreurs et favoris sauvegardés sur votre téléphone.

### Contenu
- Principes et valeurs de la République
- Système institutionnel et politique
- Droits et devoirs
- Histoire, géographie et culture
- Vivre dans la société française

### Idéal pour
- Préparer une naturalisation ou un entretien civique
- Réviser les bases de la citoyenneté française
- Apprendre vite avec des explications courtes et claires

## Structure du projet
```txt
lib/
  main.dart
  app/
  data/
    purchase_service.dart
    revision_fiches.dart
  features/
    account/
    home/
    premium/
    quiz/
    results/
    revision/
    mistakes/
    theme_selection/
  models/
  widgets/
assets/data/examen_civique_questions.json
```

## Build Android release
```bash
flutter pub get
flutter build apk --release
flutter build appbundle --release
```

## Checklist release Android
- [ ] Mettre un `applicationId` final dans `android/app/build.gradle`.
- [ ] Remplacer l’icône temporaire par l’icône finale.
- [ ] Configurer la signature `keystore` release.
- [ ] Vérifier version `version: x.y.z+n` dans `pubspec.yaml`.
- [ ] Générer AAB : `flutter build appbundle --release`.
- [ ] Tester sur au moins 2 appareils Android.
- [ ] Préparer fiche Play Store (titre, sous-titre, screenshots, politique confidentialité).
- [ ] Soumettre sur Google Play Console.

## Idées de screenshots Play Store
1. Écran d’accueil avec statut Gratuit/Premium.
2. Écran quiz avec progression + cartes de réponses.
3. Paywall Premium avec bénéfices.
4. Fiches de révision avec recherche et filtres.
5. Détail fiche avec “À retenir” et “Pièges fréquents”.
6. Résultats + revoir mes erreurs Premium.

## Script vidéo promo (15-20s)
- 0-3s : Logo + texte "Réussissez l’examen civique français"
- 3-7s : Home screen, tap sur "Commencer"
- 7-11s : Quiz avec progression et sélection réponse
- 11-14s : Résultat final + score
- 14-17s : Fiches, erreurs/favoris et Premium
- 17-20s : CTA "Téléchargez Examen Civique FR"
