# Romulus — 2D Combat Prototype

### A timing-focused melee combat system developed in Godot 4

## Project Overview

Romulus is an independently designed 2D melee-combat prototype exploring deliberate swordplay, precise combo timing, attack commitment, and reactive enemy behaviour.

The objective is to develop a combat system that rewards player skill and deliberate inputs rather than repetitive button-mashing.

This project also serves as a practical game-design portfolio, documenting how gameplay ideas evolve through implementation, testing, and iteration.

## Design Philosophy

The combat system is built around four principles:

- **Precision over button-mashing:** Successfully chaining attacks requires carefully timed inputs.
- **Attack commitment:** Players temporarily sacrifice movement during committed sword attacks.
- **Meaningful enemy reactions:** Successful hits, blocks, parries, and knockback should produce distinct combat outcomes.
- **Skill-based progression:** Players should improve through understanding timing, positioning, and enemy behaviour.

## Implemented Features

The current prototype includes:

- Four-direction character movement and animations.
- Keyboard and controller input support.
- Normal and reverse sword-slash animations.
- Timing-dependent alternating sword combos.
- Early-input penalties that interrupt combo chains.
- Directional sword hit detection.
- Active attack frames and one-hit-per-swing tracking.
- A training dummy with physical collision and health.
- Damage calculations: 10 damage for a single slash and 28 total damage for a successful two-hit combo.

## Planned Features

The following mechanics are designed but not yet fully implemented:

- Brief hitstop and red visual feedback on successful hits.
- Enemy guarding and blocked-attack reactions.
- Knockback on chained attacks.
- Charged thrusts, skewering, and parrying.
- Player hitstun and recovery.
- Dodging and expanded movement mechanics.
- Reactive enemy AI and combat encounter design.

## Development Documentation

The project includes **Romulus Development Report v0.1**, documenting the initial development process, technical challenges, solutions, gameplay testing, and design decisions.

Future reports will include additional implementation results, gameplay screenshots, and short video demonstrations.

## Technology

- **Engine:** Godot 4
- **Language:** GDScript
- **Graphics:** Universal LPC character sprites
- **Development approach:** Iterative prototyping and playtesting

## Development Contributions and AI Assistance

Combat mechanics, gameplay rules, input timing, balancing decisions, and playtesting are directed by the project designer.

AI assistance is used for GDScript implementation, debugging, technical explanations, and development documentation.

The project is intended to demonstrate game-design reasoning, practical prototyping, and iterative problem-solving.

## Artwork Attribution

Character sprites were generated using the Universal LPC Spritesheet Character Generator.

The original artwork belongs to its respective contributors and is subject to applicable third-party licences.

The full artwork attribution records are retained separately. Character sprites are not yet included in this public repository pending completion of the licensing review.

## Project Status

**Early prototype — active development**

The combat system is undergoing incremental development and testing. This repository currently contains source code and documentation, but is not yet a complete downloadable or playable demonstration.
