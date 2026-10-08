<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Weight (entity_weight) — agent index

Adds a configurable integer weight field (`field_entity_weight`) to **any fieldable entity type** for
custom drag-and-drop ordering. Package `Custom`. Core `^10.1 || ^11`. License GPL-2.0-or-later.
Version 1.0.2. No composer/library/module dependencies (Field + Field UI are core). Provides 2
permissions and a config object; no Drush, no custom plugin types.

## Solution docs
- **Settings form, config object, field lifecycle** → [config/settings.md](config/settings.md)
- **The weight field + `entity_weight_selector` widget** → [fields/weight-field.md](fields/weight-field.md)
- **Drag-and-drop ordering interface + batch save** → [forms/ordering.md](forms/ordering.md)
- **Submodule Entity Weight Views (per-view order)** →
  [../modules/entity_weight_views/1.0.x/agent/start.md](../modules/entity_weight_views/1.0.x/agent/start.md)

## What it provides (from source)
- **Config object** `entity_weight.settings` (`config/install`, `config/schema`): `enabled_bundles`
  (sequence per entity type), `min_weight` (-100), `max_weight` (100), `include_unpublished` (TRUE).
- **Permissions** (`entity_weight.permissions.yml`): `administer entity weight`, `assign entity weight`.
- **Routes** (`entity_weight.routing.yml`):
  - `entity_weight.settings` — `/admin/config/entity-weight`, form `EntityWeightSettingsForm`,
    perm `administer entity weight`.
  - `entity_weight.order` — `/admin/structure/entity-weight/{entity_type_id}/{bundle}/order`,
    form `EntityOrderForm`, perm `assign entity weight`.
  - `entity_weight.list` — `/admin/structure/entity-weight`, core `SystemController` menu block page,
    perm `assign entity weight`.
- **Field widget plugin** `entity_weight_selector` (`EntityWeightSelectorWidget`, integer field type).
- **Menu link deriver** `EntityWeightMenuLink` (`Plugin/Derivative` + `Plugin/Menu`) — one child link
  per enabled bundle under `entity_weight.list`.
- **Procedural helpers** in `entity_weight.module`: `entity_weight_applicable_entity_types()`,
  `entity_weight_is_enabled()`, `entity_weight_create_field()`, `entity_weight_update_field()`,
  `entity_weight_delete_field()`; `hook_help()`. `hook_uninstall()` in `entity_weight.install`
  deletes all field instances + storage.

## Mechanism in one line
Enabling a bundle creates a **locked** `field_entity_weight` integer field storage/instance and a
hidden form-display widget; the order form sorts entities by that field and batch-saves new weights;
Views reads `field_entity_weight` as a normal field sort.
