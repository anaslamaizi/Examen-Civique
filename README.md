# Examen Civique FR

Application Flutter Android-first pour préparer l'examen civique français, hors ligne.

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
  features/
    home/
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
1. Écran d’accueil (3 modes: commencer, thème, test complet)
2. Écran quiz avec progression + cartes de réponses
3. Correction instantanée avec explication
4. Résultats avec score et pourcentage
5. Flashcards révision question/réponse
6. Écran erreurs & favoris

## Script vidéo promo (15-20s)
- 0-3s : Logo + texte "Réussissez l’examen civique français"
- 3-7s : Home screen, tap sur "Commencer"
- 7-11s : Quiz avec progression et sélection réponse
- 11-14s : Résultat final + score
- 14-17s : Flashcards + erreurs/favoris
- 17-20s : CTA "Téléchargez Examen Civique FR"
