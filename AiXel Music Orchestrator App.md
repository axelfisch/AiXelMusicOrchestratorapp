# AiXel Music Orchestrator App

Une application iOS sophistiquée pour générer et orchestrer des compositions jazz-pop dans le style d'Axel Fisch, avec des progressions d'accords alimentées par l'IA, une orchestration à 8 voix, et des capacités d'export audio professionnel.

## 🆕 Nouvelles Fonctionnalités (Version Mise à Jour)

### 🤖 Intégration Chatbot GPT
- **Assistant Musical Intelligent**: Chatbot intégré basé sur GPT pour conseils de composition et d'orchestration
- **Système de Prompts Personnalisé**: Prompts spécialement conçus pour l'esthétique musicale d'Axel Fisch
- **Historique Persistant**: Conversations sauvegardées entre les sessions pour un contexte continu
- **Interface Chat Intuitive**: Messages utilisateur alignés à droite, réponses assistant à gauche

### 🎼 Améliorations de l'Orchestration
- **Style Axel Fisch Intégré**: Accords add9, sus2, sus4, maj7(11+), min9, 13(b9), 7(9+5+)
- **Approche Tension-Résolution**: Système "Approche → Tension → Résolution" automatisé
- **Tests Unitaires**: Validation de la logique réseau et stabilité de l'application

## Fonctionnalités Principales

### 🎵 Génération de Compositions
- **Progressions d'Accords IA**: Génération de progressions jazz-pop sophistiquées utilisant le vocabulaire harmonique d'Axel Fisch
- **Structure Forme AABA**: Forme classique de 32 mesures avec conduite de voix intelligente
- **Tonalités Multiples**: Support pour toutes les tonalités majeures et mineures avec échange modal
- **Variations de Style**: Jazz-pop, contemporain, et styles fusion

### 🎼 Orchestration 8 Voix
- **Instrumentation Professionnelle**: Flûte, Piano, Violon I & II, Alto I & II, Violoncelle, Contrebasse
- **Voicing Intelligent**: Conduite de voix automatique et orchestration basée sur les principes jazz
- **Audio Temps Réel**: Moteur de lecture haute qualité alimenté par AudioKit
- **Contrôle Individuel**: Volume, réverbération, et contrôles de sourdine pour chaque instrument

### 🎛️ Mixeur Avancé
- **Interface Professionnelle**: Mixeur 8 canaux avec contrôles individuels
- **Traitement Temps Réel**: Effets audio en direct et ajustement de paramètres
- **Retour Visuel**: Esthétique d'équipement audio professionnel
- **Optimisé Tactile**: Conçu pour l'interaction tactile iOS

### 💬 Assistant Chatbot Intégré
- **ChatManager**: Gestionnaire ObservableObject pour l'historique des messages
- **API OpenAI**: Intégration avec votre GPT personnel via clé API sécurisée
- **Interface ChatbotView**: Vue dédiée pour converser avec l'assistant
- **Onglet Chat**: Nouvel onglet dans l'interface principale

### 📤 Capacités d'Export
- **Export MIDI**: Fichiers MIDI standard compatibles avec tous les DAW
- **Export MusicXML**: Compatibilité avec les logiciels de notation professionnels
- **Export Audio**: Fichiers WAV haute qualité pour partage et production
- **Partitions PDF**: Génération de partitions imprimables

## Architecture Technique

### Technologies Principales
- **Swift 5.0** avec SwiftUI pour le développement iOS moderne
- **AudioKit** pour le traitement audio professionnel et la lecture
- **Intégration Python** pour les algorithmes avancés de théorie musicale et composition
- **Core Audio** pour les performances audio à faible latence
- **OpenAI API** pour l'assistant chatbot intelligent

### Composants Clés

#### Moteur Audio
```swift
// Traitement audio haute performance
AudioManager: Lecture audio temps réel et mixage
InstrumentEngine: Traitement audio d'instruments individuels
Intégration AudioKit: Framework audio professionnel
```

#### Moteur de Composition
```swift
// Génération musicale alimentée par l'IA
OrchestrationManager: Logique de composition et d'orchestration
PythonBridge: Intégration avec les algorithmes de théorie musicale
MusicalModels: Structures de données principales pour les concepts musicaux
```

#### Assistant Chatbot
```swift
// Intégration GPT pour assistance musicale
ChatManager: Gestion des conversations et historique
ChatbotView: Interface utilisateur pour le chat
OpenAI Integration: Communication avec l'API GPT
```

#### Interface Utilisateur
```swift
// Interface SwiftUI moderne
ContentView: Interface principale de l'application avec onglet Chat
MixerView: Mixeur professionnel 8 canaux
CompositionView: Contrôles de génération de composition
ExportView: Export et partage de fichiers
ChatbotView: Interface de chat avec l'assistant IA
```

## Installation et Configuration

### Prérequis
- **Xcode 15.0+** avec cible de déploiement iOS 15.0+
- **macOS 13.0+** pour le développement
- **Compte Développeur Apple** pour les tests sur appareil et soumission App Store
- **Python 3.8+** pour le moteur d'orchestration
- **Clé API OpenAI** pour l'assistant chatbot

### Dépendances
L'application utilise les dépendances clés suivantes :
- AudioKit (traitement audio)
- AudioKitUI (composants d'interface audio)
- MIDIKit (génération de fichiers MIDI)
- PythonKit (intégration Python)

### Instructions de Construction

1. **Cloner le Dépôt**
   ```bash
   git clone https://github.com/axelfisch/AiXelMusicOrchestratorapp.git
   cd AiXelMusicOrchestratorapp
   ```

2. **Ouvrir dans Xcode**
   ```bash
   open AiXelMusicOrchestrator.xcodeproj
   ```

3. **Configurer les Dépendances**
   - Ajouter AudioKit via Swift Package Manager
   - Configurer l'environnement Python pour le moteur d'orchestration
   - Configurer la signature de code avec votre compte Apple Developer

4. **Configuration de l'API OpenAI**
   - Obtenir une clé API OpenAI
   - Ajouter la variable d'environnement `OPENAI_API_KEY` dans le schéma Xcode
   - Ou configurer via les paramètres de l'application

5. **Construire et Exécuter**
   - Sélectionner l'appareil cible ou le simulateur
   - Construire et exécuter le projet (⌘+R)

### Configuration

#### Paramètres Audio
```swift
// Configurer le moteur audio dans AudioManager
let audioEngine = AudioEngine()
audioEngine.settings.bufferLength = .medium
audioEngine.settings.sampleRate = 44100
```

#### Environnement Python
```python
# Installer les packages Python requis
pip install music21 numpy scipy
```

#### Configuration OpenAI
```swift
// Configuration de l'API OpenAI dans ChatManager
let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"]
```

## Guide d'Utilisation

### Génération de Compositions

1. **Sélectionner les Paramètres**
   - Choisir la tonalité (C, Eb, F#, etc.)
   - Sélectionner la forme (AABA)
   - Choisir le style (Jazz Pop)
   - Définir le tempo (60-200 BPM)

2. **Générer la Composition**
   - Appuyer sur le bouton "Generate Composition"
   - Attendre le traitement IA (2-5 secondes)
   - Réviser la progression d'accords générée

3. **Lecture et Mixage**
   - Utiliser les contrôles de lecture pour démarrer/arrêter
   - Ajuster les niveaux d'instruments individuels
   - Appliquer la réverbération et les effets

### Utilisation de l'Assistant Chatbot

1. **Accéder au Chat**
   - Naviguer vers l'onglet "Chat"
   - L'historique des conversations précédentes se charge automatiquement

2. **Converser avec l'Assistant**
   - Taper votre question sur la composition ou l'orchestration
   - Recevoir des conseils personnalisés dans le style d'Axel Fisch
   - L'assistant connaît vos accords préférés : add9, sus2, maj7(11+), etc.

3. **Conseils Musicaux**
   - Demander des analyses harmoniques
   - Obtenir des suggestions de progressions d'accords
   - Recevoir des conseils d'orchestration spécifiques

### Export de Votre Travail

1. **Export MIDI**
   - Naviguer vers l'onglet Export
   - Sélectionner "Export MIDI"
   - Partager ou sauvegarder dans l'app Fichiers

2. **Export Audio**
   - Choisir "Export Audio"
   - Sélectionner les paramètres de qualité
   - Générer le fichier WAV

3. **Partitions**
   - Sélectionner "Export MusicXML"
   - Ouvrir dans un logiciel de notation
   - Imprimer ou éditer davantage

## Développement

### Structure du Projet
```
AiXelMusicOrchestrator/
├── AiXelMusicOrchestrator/
│   ├── Views/                 # Composants d'interface SwiftUI
│   │   ├── ChatbotView.swift  # Interface de chat
│   │   └── ContentView.swift  # Interface principale avec onglets
│   ├── Models/                # Modèles de données principaux
│   ├── ViewModels/            # Modèles de vue MVVM
│   ├── Managers/              # Gestionnaires système
│   │   └── ChatManager.swift  # Gestionnaire de chat GPT
│   ├── Audio/                 # Moteur de traitement audio
│   ├── Utils/                 # Classes utilitaires et extensions
│   └── Resources/             # Scripts Python et assets
├── AiXelMusicOrchestratorTests/  # Tests unitaires et d'intégration
│   └── ChatManagerTests.swift    # Tests pour le gestionnaire de chat
├── Assets/                    # Icônes d'app et assets visuels
└── Documentation/             # Documentation technique
```

### Classes Clés

#### ChatManager
Gestionnaire central pour les conversations avec l'assistant GPT.
```swift
class ChatManager: ObservableObject {
    @Published var messages: [ChatMessage] = []
    
    func sendMessage(_ content: String) async
    func loadConversationHistory()
    func saveConversationHistory()
}
```

#### OrchestrationManager
Le coordinateur central pour la génération de composition et l'orchestration.
```swift
class OrchestrationManager: ObservableObject {
    func generateComposition(parameters: CompositionParameters) async -> Composition
    func generateVoicing(for chord: Chord) -> Voicing?
    func applyAxelFischStyle(to progression: [Chord]) -> [Chord]
}
```

#### AudioManager
Gère toute la lecture audio et le traitement temps réel.
```swift
class AudioManager: ObservableObject {
    func initializeAudioEngine() -> Bool
    func loadComposition(_ composition: Composition)
    func setVolume(_ volume: Float, for instrument: InstrumentType)
    func setReverb(_ reverb: Float, for instrument: InstrumentType)
}
```

### Tests

#### Exécution des Tests
```bash
# Exécuter tous les tests
xcodebuild test -scheme AiXelMusicOrchestrator -destination 'platform=iOS Simulator,name=iPhone 15'

# Exécuter une suite de tests spécifique
xcodebuild test -scheme AiXelMusicOrchestrator -only-testing:AiXelMusicOrchestratorTests
```

#### Couverture de Tests
- Tests unitaires pour la génération de composition
- Tests d'intégration pour la lecture audio
- Tests de performance pour l'optimisation
- Tests UI pour l'interaction utilisateur
- **Nouveaux**: Tests pour ChatManager et intégration GPT

### Optimisation des Performances

Voir [PERFORMANCE_OPTIMIZATION.md](PERFORMANCE_OPTIMIZATION.md) pour les directives détaillées de performance et les stratégies d'optimisation.

Objectifs de performance clés :
- Latence audio : < 20ms
- Fréquence d'images UI : 60fps
- Utilisation mémoire : < 400MB
- Génération de composition : < 5s
- Réponse chatbot : < 3s

## Style Musical d'Axel Fisch

L'application implémente le vocabulaire harmonique sophistiqué et les techniques d'orchestration d'Axel Fisch :

### Caractéristiques Harmoniques
- **Accords Étendus**: maj9, min13, sus(b9), 7(#11)
- **Échange Modal**: Emprunt aux modes parallèles
- **Conduite de Voix Chromatique**: Lignes de basse fluides et voix intérieures
- **Substitutions Tritoniques**: Substitutions harmoniques avancées

### Principes d'Orchestration
- **Voicing Équilibré**: Distribution optimale sur 8 voix
- **Écriture Idiomatique**: Chaque instrument joue dans sa tessiture naturelle
- **Variété Texturale**: Jeu dynamique entre les instruments
- **Harmonie Jazz**: Voicings d'accords sophistiqués et progressions

### Assistant IA Spécialisé
- **Prompts Système Personnalisés**: Intégration des préférences harmoniques d'Axel Fisch
- **Conseils Contextuels**: Suggestions basées sur l'esthétique musicale spécifique
- **Mémoire Conversationnelle**: Continuité entre les sessions pour un meilleur contexte

## Comment Utiliser

### Décompresser et Ouvrir
1. Décompresser l'archive `AiXelMusicOrchestratorapp.zip`
2. Ouvrir `AiXelMusicOrchestrator.xcodeproj` dans Xcode
3. Ajouter la variable d'environnement `OPENAI_API_KEY` avec votre clé OpenAI
4. Lancer l'application sur un simulateur ou appareil iOS

### Configuration de la Clé API
Dans le schéma d'exécution Xcode :
1. Aller dans Product → Scheme → Edit Scheme
2. Sélectionner "Run" dans la barre latérale
3. Aller à l'onglet "Environment Variables"
4. Ajouter `OPENAI_API_KEY` avec votre clé API OpenAI

## Prochaines Étapes Possibles

### Améliorations Suggérées
- **Affiner les Réponses Musicales**: Envoyer des prompts système plus spécifiques à l'esthétique d'Axel Fisch
- **Personnalisation de l'Interface**: Couleurs, bulles de chat, animations
- **Fonctions de Formation**: Analyses harmoniques et exercices pour l'utilisateur
- **Paramètres de Prompts**: Permettre à l'utilisateur d'ajuster l'esthétique via les réglages

## Contribuer

Nous accueillons les contributions pour améliorer l'AiXel Music Orchestrator. Veuillez suivre ces directives :

1. **Fork le Dépôt**
2. **Créer une Branche de Fonctionnalité**
   ```bash
   git checkout -b feature/fonctionnalite-incroyable
   ```
3. **Committer les Changements**
   ```bash
   git commit -m 'Ajouter fonctionnalité incroyable'
   ```
4. **Pousser vers la Branche**
   ```bash
   git push origin feature/fonctionnalite-incroyable
   ```
5. **Ouvrir une Pull Request**

### Style de Code
- Suivre les Directives de Conception d'API Swift
- Utiliser les meilleures pratiques SwiftUI
- Inclure des tests unitaires pour les nouvelles fonctionnalités
- Documenter les APIs publiques

## Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour les détails.

## Remerciements

- **Axel Fisch** - Style musical et concepts harmoniques
- **Équipe AudioKit** - Framework audio professionnel
- **Communauté Swift** - Langage et support écosystème
- **OpenAI** - Technologie GPT pour l'assistant intelligent
- **Contributeurs Théorie Musicale** - Recherche académique et ressources

## Support

Pour le support, demandes de fonctionnalités, ou rapports de bugs :

- **GitHub Issues**: [Créer un issue](https://github.com/axelfisch/AiXelMusicOrchestratorapp/issues)
- **Email**: axel.fisch@example.com
- **Documentation**: [Wiki](https://github.com/axelfisch/AiXelMusicOrchestratorapp/wiki)

## Feuille de Route

### Version 1.1
- [ ] Styles musicaux additionnels
- [ ] Progressions d'accords personnalisées
- [ ] Options d'export avancées
- [ ] Interface optimisée iPad
- [x] **Intégration chatbot GPT**
- [x] **Historique de conversation persistant**
- [x] **Tests unitaires pour ChatManager**

### Version 1.2
- [ ] Collaboration temps réel
- [ ] Stockage de compositions cloud
- [ ] Effets audio avancés
- [ ] Support contrôleur MIDI
- [ ] Personnalisation interface chat

### Version 2.0
- [ ] Composition par apprentissage automatique
- [ ] Génération de mélodie vocale
- [ ] Enregistrement multi-pistes
- [ ] Outils de mixage professionnels
- [ ] Assistant IA multimodal (audio + texte)

---

**AiXel Music Orchestrator App** - Apporter l'orchestration jazz-pop sophistiquée à iOS avec l'intelligence artificielle.

*Construit avec ❤️ pour les musiciens et compositeurs par Axel Fisch.*


