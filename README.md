# Ball Physics

A Flutter mobile game featuring realistic ball physics simulation with interactive gameplay.

## 🎮 Main Functionality

**Ball Physics** is an engaging mobile game where players tap the screen to keep a ball bouncing. The app includes:

- **Menu Screen**: Main entry point with animated gradient background, featuring "Start Game" and "Leaderboard" buttons
- **Game Screen**: Interactive physics-based gameplay where players tap to apply upward force to the ball, keeping it bouncing while avoiding the floor. Features include:
  - Real-time physics simulation with gravity, velocity, and collision detection
  - Score tracking based on successful bounces
  - Pause/resume functionality
  - Visual feedback animations for taps
  - Dynamic ball shadow effects
- **Leaderboard Screen**: Displays top scores saved locally using SharedPreferences

## 🏗️ Architecture

The project follows **Clean Architecture** principles with clear separation of concerns:

- **Presentation Layer**: UI components, screens, widgets, and state management using BLoC/Cubit pattern
- **Domain Layer**: Business logic and models (e.g., `TapFeedback`, `ScoreRecord`)
- **Data Layer**: Local data persistence via `SharedPreferences` for leaderboard storage

### Key Architectural Features

- **State Management**: BLoC pattern with Cubits for game state, navigation, and leaderboard
- **Dependency Injection**: GetIt service locator for managing dependencies
- **Navigation**: GoRouter for declarative routing with custom page transitions
- **Reusable Components**: Shared widgets library including gradient buttons, glass cards, and custom dialogs
- **Service Layer**: Modular services for leaderboard management and logging
- **Theme System**: Centralized theming with support for light/dark modes, custom colors, fonts, and spacing

## 🛠️ Tech Stack

- **Flutter** with Dart
- **flutter_bloc** for state management
- **go_router** for navigation
- **get_it** for dependency injection
- **shared_preferences** for local data storage
- **equatable** for value equality
- **talker_flutter** & **talker_bloc_logger** for logging and debugging

## 📱 Features

- Realistic physics simulation with gravity, restitution, and velocity limits
- Smooth animations and visual feedback
- Local leaderboard persistence
- Responsive UI with gradient backgrounds
- Pause/resume game functionality
- Score tracking system
