<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Displays an interactive Graphviz diagram of the entities that a node, taxonomy term, or user references, so you can see how content depends on other content.

---

Entity Dependency Visualizer adds a "Content dependencies" local task tab to content entities (nodes, taxonomy terms, users). Opening the tab walks the entity's entity-reference, file, and image fields, builds a Graphviz DOT graph of the reference chain (capped at a nesting depth of 100, or 2 levels when there are more than 1000 items), and renders it client-side to an SVG with pan, zoom, and mouse-wheel scaling. Each node is coloured by entity type, links back to that entity's own dependency tab so you can drill down, and can show the bundle, entity id, and referencing field on the arrows. A settings form at /admin/config/development/entity_dependency_visualizer/settings controls graph size, direction, node shape, caption (uuid/id/label), ellipsis truncation, ignored fields, and which dependency-calculator plugin is used. Dependency calculation is pluggable through the module's own DependenciesCalculator plugin type: the built-in "native" plugin traverses reference fields directly, and the optional entity_dependency_visualizer_depcalc submodule delegates to the contrib depcalc module. Supports Drupal 10.2 through 12.

---

- Visualize which entities a given node references, as a graph.
- See a taxonomy term's dependency tree from its canonical page.
- Inspect the entities referenced from a user account.
- Detect circular dependencies between content items before deleting them.
- Understand nested paragraph structures inside a node.
- Trace image and file references attached to content.
- Follow entity_reference and entity_reference_revisions chains visually.
- Drill down node-by-node by clicking a graph node to open its own dependency graph.
- Pan and zoom around a large dependency graph in the browser.
- Search for a string within the rendered SVG graph.
- Limit graph depth automatically on very large content sets to avoid timeouts.
- Label graph arrows with the referencing field name for auditing.
- Show entity ids and bundle names on the graph for debugging content models.
- Choose whether nodes are captioned by uuid, id, or label.
- Customize graph appearance (size, ratio, direction, fonts, node shape/colour) from the admin form.
- Exclude noisy reference fields from the graph via the "ignore fields" list.
- Export the generated Graphviz DOT source (enable "Show Graphviz Object") to paste into webgraphviz.com.
- Switch between the native calculator and the depcalc-based calculator.
- Plan safe content deletions by reviewing what depends on an entity.
- Audit content synchronization/staging relationships across a site.
- Provide developers and site builders a quick relationship map of the content model.
- Diagnose why an entity cannot be deleted because other content references it.
- Add support for further content entity types by implementing a get<Type>Graph() controller method.
