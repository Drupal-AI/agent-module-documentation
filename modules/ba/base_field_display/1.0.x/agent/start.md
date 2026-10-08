<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BaseField Display (base_field_display) — agent index

Makes selected entity **base fields** display-configurable so they appear as rows in the
Manage Display UI / view modes, with type-appropriate formatters. PHP >= 8.0. Core `^9 || ^10 || ^11`.
Depends on core `path`. Package **Fields**. Version **1.0.1**.

## How it works
- `hook_entity_base_field_info_alter` → `BaseFieldDisplayManager::entityBundleFieldInfoAlter()` calls
  `->setDisplayConfigurable('view', TRUE)` on each base field named in config for that entity type, and
  adds a computed `path` field `base_field_display_alias` ("Alias") to every entity type with a
  `canonical` link template.
- `hook_entity_type_build` sets `enable_base_field_custom_preprocess_skipping` on node/taxonomy_term.
- `hook_preprocess_node` / `hook_preprocess_taxonomy_term` re-render the `title`/`name` base field when
  activated (unsets `#printed`, clears `#is_page_title`) so it can show both in the `h1` and as a field.
- Rendering + field access use core's normal display pipeline — the module does not alter access.

## Provides
- Service `base_field_display.manager` (`BaseFieldDisplayManager`, arg `@config.factory`), interface
  `BaseFieldDisplayManagerInterface`.
- Config settings form route `base_field_display.settings_form` at
  `/admin/config/content/base-field-display` (menu link under system.admin_config_content).
- Config object `base_field_display.settings` (sequence keyed by entity-type id → list of base-field
  machine names). Schema in `config/schema/base_field_display.schema.yml`.
- Computed field-item-list class `AliasComputed` (extends core `PathFieldItemList`).
- Field formatters: `base_field_display_string` (Plain text; `uuid`, `password`),
  `base_field_display_path_string` (String; `path`).

## Solution docs
- Configuration + route/permission + config object: [agent/config/settings.md](config/settings.md)
- Service, hooks, computed Alias field: [agent/api/manager.md](api/manager.md)
- Field formatters: [agent/plugins/formatters.md](plugins/formatters.md)
