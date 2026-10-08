<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Dependency Visualizer + Dependency Calculator (entity_dependency_visualizer_depcalc) — agent index

Optional submodule of **entity_dependency_visualizer**. Adds a `depcalc` DependenciesCalculator plugin
that delegates dependency calculation to contrib **depcalc** instead of the parent's native field
traversal. Package `Content`. Core `^10.2 || ^11`. License GPL-2.0-or-later. Version dir `8.x-1.x`.

- Dependencies: `depcalc:depcalc`, `entity_dependency_visualizer:entity_dependency_visualizer`.
- No routes, permissions, config, or schema of its own — it uses the parent's settings form and
  `use entity dependencies` permission; graph appearance is the parent config object.

## What it provides (from source)

- **Plugin** `DependenciesCalculatorDepcalc` (`#[DependenciesCalculator(id:'depcalc', name:'DepCalc')]`,
  `src/Plugin/DependenciesCalculator/DependenciesCalculatorDepcalc.php`) — extends the parent's
  `DependenciesCalculatorAbstract`; `populateDependencies()` runs depcalc
  `DependencyCalculator::calculateDependencies()` for the viewed entity.
- **Event subscriber** `EventSubscriber\DependencyCollector` (service
  `entity_dependency_visualizer_depcalc.dependency_collector`, extends depcalc `BaseDependencyCollector`,
  priority -1) — on `CALCULATE_DEPENDENCIES` pushes each content entity into the parent's
  `DependencyStack` (users skipped; some `info` fields are `@todo` stubs).

Details: [plugins/depcalc.md](plugins/depcalc.md). Parent docs: `../../../8.x-1.x/agent/start.md`.
