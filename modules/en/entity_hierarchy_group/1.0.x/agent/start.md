<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Hierarchy Group Support (entity_hierarchy_group) — agent index

Makes `entity_hierarchy` parent selection group-aware. It overrides entity_hierarchy's
entity-reference-selection handler so the parent options offered on an
`entity_reference_hierarchy` field can be limited to the current Group context, and adds a
validation constraint that can enforce one hierarchy root per group. Package **Entity Hierarchy**.
Depends on **`entity_hierarchy`** and **`group`** (composer: `drupal/entity_hierarchy:^5.0`,
`drupal/group:^3.0`). Core `^10.5 || ^11.2`. License GPL-2.0-or-later. Version **1.0.0-alpha2**
(pre-release, not security-covered). **No permissions of its own**; **no Drush**; **no new plugin types**.

## What it provides

- **Config + settings form** (three checkboxes, config object `entity_hierarchy_group.settings`,
  admin route under Administration -> Groups) → [config/settings.md](config/settings.md)
- **Integration mechanism** — the helper service, the two hooks that swap the selection handler
  and attach the constraint, the `EntityHierarchyGroup` selection plugin, and the
  `GroupHierarchyParent` validation constraint → [api/integration.md](api/integration.md)

## Submodule

- **`entity_hierarchy_widgets_group`** — applies the same group filtering to the nested tree
  widget from `entity_hierarchy_widgets`. Documented separately at
  `modules/en/entity_hierarchy_group/modules/entity_hierarchy_widgets_group/1.0.x/`.

## Quick facts

- Enable: `drush en entity_hierarchy_group` (pulls in entity_hierarchy + group).
- No-op until at least one setting is enabled; escapes all option labels; all internal entity
  queries run with `accessCheck(TRUE)`.
- Settings route: `entity_hierarchy_group.entity_hierarchy_group_settings` at
  `/admin/group/entity-hierarchy-group-settings` (permission `administer site configuration`).
