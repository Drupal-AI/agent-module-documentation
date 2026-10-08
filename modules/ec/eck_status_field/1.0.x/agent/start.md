<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECK Status Field (eck_status_field) — agent index

Adds a core-style **`status` (published) base field to ECK (Entity Construction Kit) entity types**,
giving custom ECK entities the same publish/unpublish toggle nodes have. Depends only on `eck`.
Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1.

- **How the field is enabled, attached, and used (all hooks + both entity classes)** →
  [fields/status-field.md](fields/status-field.md)

## What it actually is
- No routes, services, permissions, config schema, install hooks, plugins, or Drush. Pure
  `.module` hooks plus two thin entity subclasses.
- Enable per ECK type via a "Published field" checkbox added to the ECK entity type form; the
  value is stored as `published` in `eck.eck_entity_type.<id>` config.
- When on: entity class becomes `PublishedEckEntity` (`implements EntityPublishedInterface`,
  `use EntityPublishedTrait`), `entity_keys['published'] = 'status'`, and a display-configurable
  `status` base field is attached via `hook_entity_base_field_info()`.

## Key files
- `eck_status_field.module` — `_form_eck_entity_type_form_alter` (checkbox), `_entity_type_alter`
  (config_export + class + key), `_entity_type_build` (swap class when `published`),
  `_entity_base_field_info` (attach `status` field), `_help`.
- `src/Entity/PublishedEckEntity.php`, `src/Entity/PublishedEckEntityType.php`.

## ECK 2.0
Merged into ECK core; project documents migrating the `published` key to native `status`, then
removing this module.
