# SETUP_ANDROID

## Ce qui a été préparé automatiquement

- La plateforme Android existante a été conservée.
- Le nom affiché de l'application est `Examen Civique FR`.
- Le `applicationId` est `fr.examenciviquefr.app`.
- La version Android continue de suivre `pubspec.yaml`.
  - `versionName` = `1.0.0`
  - `versionCode` = `3`
- Les icônes Android ont été régénérées depuis `assets/icon.png`.
- La configuration Gradle de release a été rendue plus sûre :
  - utilisation de `android/key.properties` si présent
  - pas de configuration release vide forcée si le fichier manque

## Fichiers Android à connaître

- `pubspec.yaml`
- `android/app/build.gradle.kts`
- `android/app/src/main/AndroidManifest.xml`
- `android/app/src/main/res/mipmap-*`
- `android/key.properties` : local, non versionné
- `upload-keystore.jks` : local, non versionné

## Package Android

- `applicationId` / package name : `fr.examenciviquefr.app`

Le package Kotlin principal est aligné :
- `android/app/src/main/kotlin/fr/examenciviquefr/app/MainActivity.kt`

## Version Android

La version est pilotée depuis `pubspec.yaml` :

- `version: 1.0.0+3`
- `versionName` Android = `1.0.0`
- `versionCode` Android = `3`

Pour la prochaine publication :

1. augmenter `versionName` si nécessaire
2. augmenter obligatoirement le `build number` après le `+`

Exemple :

```yaml
version: 1.0.1+4
```

## Génération APK / AAB

Depuis la racine du projet :

```bash
flutter pub get
flutter build apk --release
flutter build appbundle --release
```

Le fichier recommandé pour Google Play est le `.aab` :

- sortie attendue : `build/app/outputs/bundle/release/app-release.aab`

## Signature release

La signature Android repose sur :

- `android/key.properties`
- le keystore local référencé dans ce fichier

Avant publication, vérifier :

- que le bon keystore de production est utilisé
- que `keyAlias` correspond bien à la clé de publication
- que le keystore est sauvegardé hors du dépôt

## Avant publication Google Play Console

- Vérifier le nom affiché : `Examen Civique FR`
- Vérifier l’icône générée
- Vérifier la version `versionName` / `versionCode`
- Vérifier la signature release avec le bon keystore
- Générer un `appbundle` release
- Préparer les visuels Play Store, description, politique de confidentialité si nécessaire
- Contrôler le comportement offline sur un build release

## Ce qu’il reste à vérifier manuellement

- Le keystore de publication définitif
- La cohérence finale du numéro de version avant envoi
- Les screenshots et métadonnées Play Console
- Les éventuelles obligations légales de fiche store

## Résumé publication Android

1. vérifier `pubspec.yaml`
2. vérifier `android/key.properties`
3. lancer `flutter build appbundle --release`
4. tester le build release
5. envoyer le `.aab` sur Google Play Console
