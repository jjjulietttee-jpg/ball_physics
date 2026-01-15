enum SimulationMode {
  classic,
  gravityLab,
  chaosMode,
}

extension SimulationModeExtension on SimulationMode {
  String get name {
    switch (this) {
      case SimulationMode.classic:
        return 'Classic Physics';
      case SimulationMode.gravityLab:
        return 'Gravity Lab';
      case SimulationMode.chaosMode:
        return 'Chaos Mode';
    }
  }

  String get description {
    switch (this) {
      case SimulationMode.classic:
        return 'Standard physics simulation with realistic gravity';
      case SimulationMode.gravityLab:
        return 'Experiment with different gravity values';
      case SimulationMode.chaosMode:
        return 'Random forces and impulses for unpredictable physics';
    }
  }
}
