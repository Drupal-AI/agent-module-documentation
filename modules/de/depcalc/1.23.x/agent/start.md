# Depcalc (Dependency Calculation) — agent index

Developer API that recursively computes every entity + module an entity depends on, and caches
it. No UI, config, permissions, or routes. Submodule `depcalc_ui` adds a clear-cache button.

- **Calculate dependencies: services, wrapper/stack, return shape** → [api/calculator.md](api/calculator.md)
- **Drush command & the depcalc cache bin** → [drush/commands.md](drush/commands.md)
- **The events (calculate_dependencies, filters, invalidation)** → [hooks/events.md](hooks/events.md)

Key facts:
- Service `entity.dependency.calculator` (`DependencyCalculator`); call
  `calculateDependencies(DependentEntityWrapper $wrapper, DependencyStack $stack): array`.
- Cache bin service `cache.depcalc` (`DepcalcCacheBackend`, table `cache_depcalc`) — survives
  `drush cr`; clear with `drush depcalc:clear-cache` / `dep-cc` or `deleteAllPermanent()`.
- Extensibility is via `calculate_dependencies` event subscribers named `*DependencyCollector`.
  Event constants in `Drupal\depcalc\DependencyCalculatorEvents`.
