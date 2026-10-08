<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-entity dependency graph route & controller

## Dynamic routes (`src/Routing/RouteSubscriber.php`)

`RouteSubscriber extends RouteSubscriberBase` (service `entity_dependency_visualizer.route_subscriber`,
tagged `event_subscriber`; args entity_type.manager, config.factory, the calculator plugin manager,
logger.factory). In `alterRoutes()` it loops **content entity types** only
(`ContentEntityTypeInterface`), finds each type's `entity.<type>.canonical` route, reads the configured
`dependency_calculator_plugin` (default `native`), loads that plugin definition, and derives a method
name `get<Ucwords(type)>Graph` (e.g. `getNodeGraph`, `getTaxonomytermGraph`, `getUserGraph`). If
`method_exists($plugin_class, $function)` it registers a route named
`entity_dependency_visualizer.{entity_type}_dependencies`:

- path = `{canonical_path}/entity_dependencies`
- `_controller` = `<plugin class>::get<Type>Graph`, `_title_callback` = `<plugin class>::getTitle`
- methods `GET`, option `_admin_route: TRUE`
- requirement `_permission: 'use entity dependencies'`

If no matching method exists it logs a debug message telling the developer to add
`get<Type>Graph()` to the calculator. Entity upcasting comes from core's EntityResolverManager via the
typed controller args (`NodeInterface`, `TermInterface`, `UserInterface`).

Note: only `_permission` is set on these routes — no per-entity `_entity_access` requirement is added.

## Controller methods (`src/Plugin/DependenciesCalculator/DependenciesCalculatorAbstract.php`)

The calculator plugin classes ARE the controllers (`extends ControllerBase`). `getNodeGraph()`,
`getUserGraph()`, `getTaxonomytermGraph()` each delegate to `getGraph(EntityInterface $entity)`, which:

1. `populateDependencies($entity)` fills the `DependencyStack`;
2. `getDependencyStack()->getDependencies()` returns the sorted list;
3. `new Graphviz($list)` + `getGraphViz()` builds the DOT source (see plugins/dependencies-calculator.md);
4. returns a render array: a `<div id="graphviz_svg_div">` with libraries
   `entity_dependency_visualizer/graphviz` and `.../svg_zoom` attached and the DOT string passed in
   `drupalSettings.entity_dependency_visualizer.data`. When config `show_graphviz_object` is TRUE it also
   renders a textarea with the DOT and a link to `http://www.webgraphviz.com` (opens in new tab).

`getTitle()` returns "Entity Dependencies". Helper methods build per-node metadata: `getColor()`
(user=lightpink2, file=blue, node=coral, paragraph=deepskyblue, taxonomy_term=green, default gray),
`getEntityUrl()` (points back at that entity's own `/entity_dependencies` tab), `getEntityBundle()`,
`getEntityLabel()` (`getLabel()`/`label()`/class name fallback).

## Client-side rendering

- `js/graphviz.js` (`Drupal.behaviors.entityDependencyVisualizerGraphviz`) calls
  `Viz(config.data, {format:'svg'})` (viz.js 1.8.2 from jsDelivr) and sets it as the container's
  `innerHTML`.
- `js/svg_zoom.js` wraps the SVG with `svgPanZoom` (svg-pan-zoom 3.5.0) for pan/zoom/mouse-wheel.

## Local tasks

`entity_dependency_visualizer.links.task.yml` defines tabs for `entity.node.canonical` and
`entity.taxonomy_term.canonical` (title "Entity dependencies", weight 100), pointing at the two named
routes above. (The user route exists but has no declared task link.) The menu link
(`links.menu.yml`) adds the settings page under Configuration → Development.

## Operating

1. Enable module; grant `use entity dependencies` to the intended roles.
2. Optionally pick a calculator plugin and appearance on the settings form, then **clear caches**
   (the settings submit warns; route changes require a rebuild).
3. View a node/term/user and open the "Entity dependencies" / "Content dependencies" tab.
