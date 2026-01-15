import '../../domain/models/physics_topic.dart';

class PhysicsTopicsDataSource {
  static const List<PhysicsTopic> topics = [
    PhysicsTopic(
      id: 'gravity',
      title: 'Gravity',
      description: 'Understanding gravitational force',
      content: '''
Gravity is a fundamental force that attracts objects with mass toward each other. 
On Earth, gravity pulls objects downward at approximately 9.8 m/s².

In this simulation:
• Gravity accelerates the ball downward continuously
• Higher gravity values make the ball fall faster
• Gravity affects the ball's velocity every frame
• The ball's downward speed increases over time due to gravity

Try adjusting the gravity slider to see how different values affect the ball's motion!
''',
    ),
    PhysicsTopic(
      id: 'bounce',
      title: 'Elastic Collision',
      description: 'How objects bounce and lose energy',
      content: '''
When a ball hits a surface, it bounces back due to elastic collision. However, 
no collision is perfectly elastic - some energy is always lost.

Key concepts:
• Restitution coefficient (bounce level) determines energy retention
• A value of 1.0 means perfect bounce (no energy loss)
• A value of 0.0 means no bounce (all energy lost)
• Real-world values are typically between 0.7-0.9

In this simulation, the bounce level controls how much velocity the ball retains 
after hitting the floor. Higher values mean the ball bounces higher!
''',
    ),
    PhysicsTopic(
      id: 'friction',
      title: 'Friction',
      description: 'Resistance to motion',
      content: '''
Friction is a force that opposes motion between surfaces in contact. It causes 
objects to slow down and eventually stop.

Types of friction:
• Static friction: prevents objects from starting to move
• Kinetic friction: opposes motion of moving objects
• Air resistance: friction with air molecules

In this simulation:
• Friction reduces horizontal velocity over time
• When enabled, the ball gradually slows down horizontally
• Friction doesn't affect vertical motion (gravity still applies)
• This creates more realistic physics behavior

Enable friction to see how it affects the ball's movement!
''',
    ),
    PhysicsTopic(
      id: 'velocity',
      title: 'Velocity and Acceleration',
      description: 'Speed and change in speed',
      content: '''
Velocity is the speed and direction of an object's motion. Acceleration is the 
rate at which velocity changes.

Key formulas:
• Velocity = Position change / Time
• Acceleration = Velocity change / Time
• Position = Initial position + (Velocity × Time)

In this simulation:
• The ball has both X and Y velocity components
• Gravity continuously increases downward velocity (acceleration)
• Tapping the ball adds impulse, changing its velocity
• Velocity determines how fast and in which direction the ball moves

Watch how the ball's speed changes as it falls and bounces!
''',
    ),
    PhysicsTopic(
      id: 'momentum',
      title: 'Momentum and Impulse',
      description: 'Conservation of momentum',
      content: '''
Momentum is the product of an object's mass and velocity. Impulse is a change 
in momentum caused by a force applied over time.

Key principles:
• Momentum = Mass × Velocity
• Impulse = Force × Time = Change in Momentum
• In collisions, momentum is conserved (total momentum before = after)

In this simulation:
• Tapping the ball applies an impulse
• The impulse changes the ball's velocity instantly
• Stronger taps (closer to floor) create larger impulses
• Horizontal and vertical impulses combine to create diagonal motion

Try tapping the ball at different positions to see how impulse affects its path!
''',
    ),
    PhysicsTopic(
      id: 'energy',
      title: 'Energy Conservation',
      description: 'Kinetic and potential energy',
      content: '''
Energy comes in different forms. In physics simulations, we mainly deal with 
kinetic energy (motion) and potential energy (position).

Energy types:
• Kinetic Energy = ½ × Mass × Velocity²
• Potential Energy = Mass × Gravity × Height
• Total Energy = Kinetic + Potential

In this simulation:
• As the ball falls, potential energy converts to kinetic energy
• When bouncing, kinetic energy converts back to potential energy
• Energy is lost on each bounce (due to restitution coefficient)
• Eventually, the ball stops when all energy is dissipated

The bounce level setting controls how much energy is lost on each collision!
''',
    ),
  ];

  static List<PhysicsTopic> getAllTopics() {
    return topics;
  }

  static PhysicsTopic? getTopicById(String id) {
    try {
      return topics.firstWhere((topic) => topic.id == id);
    } catch (_) {
      return null;
    }
  }
}
