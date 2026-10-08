<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# depcalc calculator plugin & collector

## Enable / use

`drush en entity_dependency_visualizer_depcalc -y` (pulls contrib `depcalc`). Then on the parent
settings form (`/admin/config/development/entity_dependency_visualizer/settings`) set
**Dependency calculator plugin = DepCalc** and clear caches so the per-entity routes rebind to this
plugin's controller methods.

## Plugin `DependenciesCalculatorDepcalc`

File `src/Plugin/DependenciesCalculator/DependenciesCalculatorDepcalc.php`,
`#[DependenciesCalculator(id:'depcalc', name:'DepCalc')]`, extends the parent's
`DependenciesCalculatorAbstract` (so it inherits `getGraph()`, the `get{Node,User,Taxonomyterm}Graph()`
controller methods, colour/url/label helpers, and the Graphviz build). Injects `entity_type.manager`,
the parent `entity_dependency_visualizer.dependency_stack`, and depcalc's `entity.dependency.calculator`.

`populateDependencies(EntityInterface $entity)` wraps the entity in a depcalc `DependentEntityWrapper`,
creates a depcalc `DependencyStack` with `ignoreCache(TRUE)`, and calls
`$this->calculator->calculateDependencies($wrapper, $stack)`. The actual graph rows are collected by the
event subscriber below.

## Event subscriber `DependencyCollector`

File `src/EventSubscriber/DependencyCollector.php`, service
`entity_dependency_visualizer_depcalc.dependency_collector` (tag `event_subscriber`, priority -1),
extends depcalc `BaseDependencyCollector`, injects the parent
`entity_dependency_visualizer.entity_dependencies_plugin`. Subscribes to
`DependencyCalculatorEvents::CALCULATE_DEPENDENCIES`; `onCalculateDependencies()` runs for each
`ContentEntityInterface` (returns early for `user`), building an `info` row (id, type, label via the
parent controller's `getEntityLabel()`, colour via `getColor()`, url via `getEntityUrl()`, uuid,
children = `array_keys($wrapper->getChildDependencies())`) and `addDependency()`s it onto the parent's
DependencyStack. `bundle`, `field`, and `depth` are still `@todo` placeholder values in this release.
