<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Dependency Visualizer (entity_dependency_visualizer) — agent index

Adds a **"Content dependencies"** local-task tab to content entities that renders a **Graphviz**
diagram of the entities a node/term/user references. Package `Content`. Core `^10.2 || ^11 || ^12`.
License GPL-2.0-or-later. Version dir `8.x-1.x` (installed release `8.x-1.0-beta2`). No hard module
deps; optional submodule `entity_dependency_visualizer_depcalc` needs contrib `depcalc`.

## What it provides (from source)

- **Dynamic per-entity routes** `entity_dependency_visualizer.{entity_type}_dependencies` at
  `{canonical_path}/entity_dependencies`, added by `Routing\RouteSubscriber` for every content
  entity type that has a matching `get<Type>Graph()` controller method. Currently node, user,
  taxonomy_term. Permission `use entity dependencies`. See [routes/graph.md](routes/graph.md).
- **Settings form** `Form\ConfigForm` at `/admin/config/development/entity_dependency_visualizer/settings`
  (route `entity_dependency_visualizer.settings`, permission `administer site configuration`), config
  object `entity_dependency_visualizer.settings`. See [config/settings.md](config/settings.md).
- **A plugin type** `DependenciesCalculator` (Attribute + Annotation + `DependenciesCalculatorManager`),
  built-in `native` plugin, optional `depcalc` plugin in the submodule; the `Controller\Graphviz`
  DOT builder, the `DependencyStack` collector, and the front-end JS libraries. See
  [plugins/dependencies-calculator.md](plugins/dependencies-calculator.md).

## Permissions

- `use entity dependencies` (`restrict access: TRUE`) — gates every per-entity graph tab.
- `administer site configuration` (core) — gates the settings form.

## Key files

- `src/Routing/RouteSubscriber.php`, `src/Controller/Graphviz.php`, `src/DependencyStack.php`
- `src/Plugin/DependenciesCalculator/*` (Abstract, Native, Interface, Manager)
- `src/Form/ConfigForm.php`, `config/{install,schema}/entity_dependency_visualizer.settings*.yml`
- `entity_dependency_visualizer.{routing,permissions,services,libraries,links.task}.yml`
- `js/graphviz.js`, `js/svg_zoom.js`
- Submodule: `modules/entity_dependency_visualizer_depcalc/**`
