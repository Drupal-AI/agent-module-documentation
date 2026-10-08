<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Hierarchy Widgets Group Support (entity_hierarchy_widgets_group) — agent index

Submodule of **entity_hierarchy_group**. Applies group-context parent filtering to the *nested
tree* entity-reference-selection handler from **`entity_hierarchy_widgets`** (the parent module
handles the plain entity_hierarchy picker). It overrides the `entity_hierarchy_nested:*` selection
plugins so the tree of candidate parents is filtered through the shared
`EntityHierarchyGroupHelper` before display. Package **Entity Hierarchy**. Core `^10.5 || ^11.2`.
License GPL-2.0-or-later. Version **1.0.0-alpha2**.

## Dependencies

`group`, `entity_hierarchy`, `entity_hierarchy_widgets`, and `entity_hierarchy_group` (see
`entity_hierarchy_widgets_group.info.yml`; composer also lists `drupal/entity_hierarchy_widgets:^1.0`
and `drupal/entity_hierarchy_group:^1.0`).

## What it provides

- **Hook + selection plugin** that swap in the group-aware nested tree handler →
  [api/selection.md](api/selection.md)

No config, no permissions, no config schema, no Drush, no new plugin types. All behaviour is
driven by the parent module's `entity_hierarchy_group.settings`. Parent module docs:
`modules/en/entity_hierarchy_group/1.0.x/`.
