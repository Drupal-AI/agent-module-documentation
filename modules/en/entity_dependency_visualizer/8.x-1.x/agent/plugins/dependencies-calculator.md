<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DependenciesCalculator plugin type, DOT builder & stack

## Plugin type

The module defines its own plugin type `DependenciesCalculator`:

- Attribute `src/Attribute/DependenciesCalculator.php` (`id`, `name`) — modern discovery.
- Annotation `src/Annotation/DependenciesCalculator.php` — legacy fallback.
- Manager `src/Plugin/DependenciesCalculator/DependenciesCalculatorManager.php` (service
  `plugin.manager.entity_dependency_visualizer`, dir `Plugin/DependenciesCalculator`, interface
  `DependenciesCalculatorInterface`, alter hook `entity_dependency_visualizer_info`).
- Interface `DependenciesCalculatorInterface` declares `getTitle`, `getDependencyStack`, `getColor`,
  `getEntityUrl`, `getEntityBundle`, `getEntityLabel`, `getGraph`, and `get{User,Node,Taxonomyterm}Graph`.

`DependenciesCalculatorAbstract extends ControllerBase` holds the shared controller/helper logic (see
routes/graph.md) and declares abstract `populateDependencies(EntityInterface $entity)`.

## Built-in plugin `native` (`DependenciesCalculatorNative`)

`#[DependenciesCalculator(id:'native', name:'Native')]`. Also registered as service
`entity_dependency_visualizer.entity_dependencies_plugin`. `populateDependencies($entity, &$list, $depth)`:

- Skips already-seen uuids (circular-dependency guard).
- Records `info` per entity: id, type, bundle, label, color, url, uuid, depth.
- Iterates `getFieldDefinitions()`; only follows fields whose type is in `supportedEntityReferenceTypes`
  = `entity_reference`, `entity_reference_revisions`, `image`, `file`, that have a target bundle, and
  are not in the `ignore_fields` config list.
- For each such field, `getReferencedEntities()` calls `$entity->{field}->referencedEntities()` but only
  for target entity types in `supportedEntityTypes` = `user`, `file`, `image`, `node`, `paragraph`,
  `taxonomy_term` (others emit a "not supported" warning message and are skipped).
- Records children uuids + which field points at each child (`child_fields`), then recurses.

## Optional plugin `depcalc` (submodule)

`modules/entity_dependency_visualizer_depcalc/` — module
`entity_dependency_visualizer_depcalc` (deps: `depcalc:depcalc`, the parent). Provides
`DependenciesCalculatorDepcalc` (`id:'depcalc'`, name 'DepCalc'), whose `populateDependencies()` runs
contrib depcalc's `DependencyCalculator::calculateDependencies()`. The event subscriber
`EventSubscriber\DependencyCollector` (extends depcalc `BaseDependencyCollector`, priority -1) listens to
`CALCULATE_DEPENDENCIES` and pushes each content entity (users skipped) into the visualizer's
`DependencyStack` with id/type/label/color/url/uuid and child uuids. Several fields are `@todo` stubs
(`bundle => '@todo bundle'`, `field => '@todo add field'`, `depth => 0`).

## DependencyStack (`src/DependencyStack.php`)

Simple keyed collector: `addDependency($uuid,$dep)`, `getDependency`, `hasDependency`,
`getDependenciesByUuid` (throws on a missing uuid), and `getDependencies()` which sorts by `info.id`
and sorts each item's `children`.

## Graphviz DOT builder (`src/Controller/Graphviz.php`)

Constructed with the dependency `$list`; `checkDepth()` drops `maxDepth` from 100 to 2 (with a warning
message) when the list exceeds 1000 items. `getGraphViz()` returns a `digraph { … }` string:

- `initGraph()` writes graph/node/arrow attribute blocks from the `graph` config (minus `size`/`arrows`).
- For each item within `maxDepth`, `addNodeFormatting()` writes a node line with `color`, `URL`
  (the entity's own dependency tab), and `label`; `getArrowLabel()` writes edges with optional order
  number, bundle/name, url (`type/id`), and referencing field, plus arrow fontsize.
- `getNodeLabel()` picks the caption (`uuid` split on `-`, `id`, or `label`); for `label` it strips
  quotes/backslashes/smart-quotes/backticks, applies ellipsis when configured, and runs
  `Xss::filter()`. The DOT string is rendered to SVG client-side (see routes/graph.md).
