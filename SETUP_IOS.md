# SETUP_IOS

## Ce qui a été préparé automatiquement

- La plateforme iOS Flutter a été ajoutée au projet.
- Le nom affiché de l’application iPhone est `Examen Civique FR`.
- Le bundle identifier a été aligné sur `fr.examenciviquefr.app`.
- La version iOS suit déjà `pubspec.yaml`.
  - `CFBundleShortVersionString` = `1.0.0`
  - `CFBundleVersion` = `3`
- Les icônes iOS ont été générées depuis `assets/icon.png`.
- Un `ios/Podfile` standard a été ajouté pour préparer CocoaPods côté Mac.
- La cible iOS minimale du projet est `iOS 13.0`.

## Fichiers iOS préparés

- `ios/Runner/Info.plist`
- `ios/Runner.xcodeproj/project.pbxproj`
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/*`
- `ios/Flutter/AppFrameworkInfo.plist`
- `ios/Flutter/Debug.xcconfig`
- `ios/Flutter/Release.xcconfig`
- `ios/Podfile`

## Bundle Identifier

- `Runner` : `fr.examenciviquefr.app`
- `RunnerTests` : `fr.examenciviquefr.app.RunnerTests`

## Version iOS

La version iOS est synchronisée avec `pubspec.yaml` :

```yaml
version: 1.0.0+3
```

Cela donne :

- version marketing iOS : `1.0.0`
- build iOS : `3`

Pour une future release :

1. augmenter la version si nécessaire
2. augmenter le build number à chaque envoi App Store Connect

## Ce qu’il restera à faire sur Mac / Xcode

Depuis Windows, la base iOS a été préparée, mais les étapes suivantes devront être faites sur macOS :

1. installer Xcode
2. ouvrir le projet Flutter sur Mac
3. lancer `flutter pub get`
4. aller dans `ios/`
5. lancer `pod install`
6. ouvrir `ios/Runner.xcworkspace` dans Xcode
7. sélectionner une `Apple Developer Team`
8. vérifier le `Signing & Capabilities`
9. tester sur simulateur iPhone et sur appareil réel si possible
10. créer l’archive iOS et l’envoyer vers App Store Connect

## Signing & Capabilities

À finaliser dans Xcode :

- `Team`
- certificat de signature
- provisioning profile
- capabilities éventuelles si vous en ajoutez plus tard

TODO Xcode :
- choisir le compte Apple Developer de publication
- vérifier que `Bundle Identifier = fr.examenciviquefr.app`
- vérifier la signature pour `Debug` et `Release`

## Génération archive iOS

Sur Mac :

```bash
flutter pub get
cd ios
pod install
cd ..
flutter build ios --release
```

Ou depuis Xcode :

1. ouvrir `ios/Runner.xcworkspace`
2. choisir `Any iOS Device`
3. menu `Product > Archive`

## Envoi vers TestFlight / App Store Connect

Depuis Xcode Organizer :

1. archiver l’application
2. valider l’archive
3. envoyer vers App Store Connect
4. distribuer via TestFlight
5. préparer ensuite la release App Store

## Blocage actuel lié à Windows

Depuis Windows, je ne peux pas finaliser :

- la compilation iOS
- `pod install`
- la signature Apple
- l’archive `.ipa`
- l’envoi vers TestFlight / App Store Connect

## Résumé reprise sur Mac

1. cloner le projet
2. lancer `flutter pub get`
3. lancer `pod install` dans `ios/`
4. ouvrir `Runner.xcworkspace`
5. configurer l’équipe Apple Developer
6. tester sur iPhone / simulateur
7. archiver puis envoyer sur TestFlight
