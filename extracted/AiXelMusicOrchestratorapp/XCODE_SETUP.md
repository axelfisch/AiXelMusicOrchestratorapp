# Instructions de Configuration Xcode pour AiXel Music Orchestrator App

## Configuration Initiale

### 1. Ouverture du Projet
```bash
# Naviguer vers le dossier du projet
cd AiXelMusicOrchestratorapp

# Ouvrir le projet Xcode
open AiXelMusicOrchestrator.xcodeproj
```

### 2. Configuration des Variables d'Environnement

#### Méthode 1 : Via le Schéma Xcode (Recommandée)
1. Dans Xcode, aller dans **Product → Scheme → Edit Scheme...**
2. Sélectionner **"Run"** dans la barre latérale gauche
3. Cliquer sur l'onglet **"Environment Variables"**
4. Cliquer sur le bouton **"+"** pour ajouter une nouvelle variable
5. Ajouter :
   - **Name**: `OPENAI_API_KEY`
   - **Value**: `votre_clé_api_openai_ici`
6. Cocher la case **"Active"**
7. Cliquer **"Close"**

#### Méthode 2 : Via Info.plist (Alternative)
1. Ouvrir `AiXelMusicOrchestrator/Info.plist`
2. Ajouter une nouvelle entrée :
   ```xml
   <key>OPENAI_API_KEY</key>
   <string>votre_clé_api_openai_ici</string>
   ```

### 3. Configuration des Dépendances Swift Package Manager

#### AudioKit
1. Dans Xcode, aller dans **File → Add Package Dependencies...**
2. Entrer l'URL : `https://github.com/AudioKit/AudioKit`
3. Sélectionner la version la plus récente
4. Ajouter à la cible **AiXelMusicOrchestrator**

#### AudioKitUI
1. Répéter le processus avec l'URL : `https://github.com/AudioKit/AudioKitUI`

### 4. Configuration de Signature de Code

#### Compte Développeur Apple
1. Dans Xcode, aller dans **Preferences → Accounts**
2. Ajouter votre compte Apple Developer
3. Sélectionner le projet dans le navigateur
4. Aller dans l'onglet **"Signing & Capabilities"**
5. Sélectionner votre équipe de développement
6. Activer **"Automatically manage signing"**

#### Bundle Identifier
- Changer le Bundle Identifier si nécessaire :
  - Format recommandé : `com.axelfisch.aixelmusicorchestrator`

### 5. Configuration des Capacités

#### Permissions Audio
Vérifier que ces permissions sont présentes dans `Info.plist` :
```xml
<key>NSMicrophoneUsageDescription</key>
<string>Cette app utilise le microphone pour l'enregistrement audio.</string>

<key>NSAppleMusicUsageDescription</key>
<string>Cette app accède à votre bibliothèque musicale pour l'export.</string>
```

#### Background Audio
1. Dans **"Signing & Capabilities"**
2. Cliquer **"+ Capability"**
3. Ajouter **"Background Modes"**
4. Cocher **"Audio, AirPlay, and Picture in Picture"**

## Tests et Débogage

### 1. Compilation Initiale
```bash
# Via ligne de commande (optionnel)
xcodebuild -scheme AiXelMusicOrchestrator -destination 'platform=iOS Simulator,name=iPhone 15' build
```

### 2. Tests Unitaires
```bash
# Exécuter tous les tests
xcodebuild test -scheme AiXelMusicOrchestrator -destination 'platform=iOS Simulator,name=iPhone 15'

# Tests spécifiques au ChatManager
xcodebuild test -scheme AiXelMusicOrchestrator -only-testing:AiXelMusicOrchestratorTests/ChatManagerTests
```

### 3. Simulateur iOS Recommandé
- **iPhone 15** (iOS 17.0+)
- **iPad Pro 12.9"** pour les tests tablette

### 4. Vérification des Fonctionnalités

#### Test de l'Assistant Chatbot
1. Lancer l'app sur le simulateur
2. Naviguer vers l'onglet **"Chat"**
3. Taper un message test : "Bonjour, peux-tu m'aider avec une progression d'accords ?"
4. Vérifier que la réponse arrive (nécessite une connexion internet)

#### Test de l'Audio
1. Aller dans l'onglet **"Composition"**
2. Générer une composition
3. Tester la lecture audio
4. Vérifier les contrôles du mixeur

#### Test d'Export
1. Générer une composition
2. Aller dans l'onglet **"Export"**
3. Tester l'export MIDI et audio

## Résolution de Problèmes Courants

### Erreur : "No such module 'AudioKit'"
**Solution** :
1. Vérifier que AudioKit est ajouté dans **Package Dependencies**
2. Nettoyer le build : **Product → Clean Build Folder**
3. Rebuilder le projet

### Erreur : "OPENAI_API_KEY not found"
**Solution** :
1. Vérifier la configuration des variables d'environnement
2. S'assurer que la clé API est valide
3. Redémarrer Xcode si nécessaire

### Erreur de Signature de Code
**Solution** :
1. Vérifier que le compte développeur est connecté
2. Changer le Bundle Identifier pour qu'il soit unique
3. Sélectionner la bonne équipe de développement

### Problèmes Audio sur Simulateur
**Solution** :
1. Tester sur un appareil physique pour l'audio complet
2. Vérifier les paramètres audio du simulateur
3. S'assurer que le volume du Mac n'est pas coupé

### Erreur de Réseau pour le Chatbot
**Solution** :
1. Vérifier la connexion internet
2. Valider la clé API OpenAI
3. Vérifier les paramètres de proxy si applicable

## Optimisations de Performance

### Configuration Debug vs Release
- **Debug** : Pour le développement et les tests
- **Release** : Pour les tests de performance et distribution

### Paramètres Audio Recommandés
```swift
// Dans AudioManager
audioEngine.settings.bufferLength = .medium  // Équilibre latence/performance
audioEngine.settings.sampleRate = 44100     // Qualité CD standard
```

### Monitoring de Performance
1. Utiliser **Instruments** pour profiler l'app
2. Surveiller l'utilisation mémoire (objectif < 400MB)
3. Vérifier la latence audio (objectif < 20ms)

## Déploiement sur Appareil

### Configuration pour Tests sur Appareil
1. Connecter l'iPhone/iPad via USB
2. Sélectionner l'appareil dans Xcode
3. S'assurer que l'appareil est en mode développeur
4. Lancer l'app (⌘+R)

### Préparation pour App Store
1. Archiver le projet : **Product → Archive**
2. Utiliser **Organizer** pour valider l'archive
3. Soumettre via **App Store Connect**

## Structure des Fichiers Importants

```
AiXelMusicOrchestrator/
├── AiXelMusicOrchestratorApp.swift    # Point d'entrée principal
├── Views/
│   ├── ContentView.swift              # Interface principale avec onglets
│   ├── ChatbotView.swift             # Interface de chat
│   ├── CompositionView.swift         # Génération de compositions
│   ├── MixerView.swift               # Contrôles audio
│   └── ExportView.swift              # Export de fichiers
├── Managers/
│   ├── ChatManager.swift             # Gestionnaire GPT
│   ├── AudioManager.swift            # Gestionnaire audio
│   └── OrchestrationManager.swift    # Gestionnaire composition
├── Models/                           # Modèles de données
├── ViewModels/                       # Logique MVVM
└── Resources/                        # Assets et scripts
```

## Checklist de Validation

### Avant le Premier Lancement
- [ ] Projet compile sans erreurs
- [ ] Variables d'environnement configurées
- [ ] Dépendances AudioKit installées
- [ ] Signature de code configurée
- [ ] Permissions audio ajoutées

### Tests Fonctionnels
- [ ] Interface principale se charge
- [ ] Onglet Chat accessible
- [ ] Chatbot répond aux messages
- [ ] Génération de composition fonctionne
- [ ] Lecture audio opérationnelle
- [ ] Contrôles mixeur réactifs
- [ ] Export MIDI/Audio réussi

### Tests de Performance
- [ ] Lancement app < 3 secondes
- [ ] Réponse chatbot < 5 secondes
- [ ] Latence audio < 20ms
- [ ] Utilisation mémoire stable
- [ ] Interface fluide (60fps)

## Support et Ressources

### Documentation Apple
- [Xcode User Guide](https://developer.apple.com/documentation/xcode)
- [Swift Package Manager](https://swift.org/package-manager/)
- [Core Audio Programming Guide](https://developer.apple.com/library/archive/documentation/MusicAudio/Conceptual/CoreAudioOverview/)

### Ressources AudioKit
- [AudioKit Documentation](https://audiokit.io/docs/)
- [AudioKit Examples](https://github.com/AudioKit/Cookbook)

### OpenAI API
- [OpenAI API Documentation](https://platform.openai.com/docs)
- [API Key Management](https://platform.openai.com/api-keys)

---

**Note** : Ce document doit être mis à jour au fur et à mesure de l'évolution du projet. Pour toute question spécifique, consulter la documentation officielle ou créer un issue sur GitHub.

