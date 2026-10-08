<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity View Mode Field Plugin (entity_view_mode_field_plugin) — agent index

Defines an annotation-based plugin type **`EntityViewModeFieldPlugin`** whose plugins compute one
scalar value from a content entity. The module registers each applicable plugin as a **display
pseudo-field (extra field)** on every content entity type/bundle, and on each entity load attaches
the computed value to the entity object as a **dynamic property named after the plugin ID**. It ships
five plugins (bundle, ID, UUID, node URL alias, term URL alias). Package **Web services**. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version **2.0.x** (dev checkout, no version line
in info.yml).

Despite the project name it does **not** expose the render view mode; the attached properties are
meant to be consumed by a normalizer (project notes cite RESTful Web Services and the companion
*Entity View Mode Normalize* module).

## What it actually is (from source)
- **No** composer.json, permissions, routes, config, schema, install file, libraries, Drush, or
  submodules. Only `.info.yml`, `.services.yml`, `.module`, and `src/`.
- **No dependencies** declared in info.yml.
- One service: `plugin.manager.entity_view_mode_field_plugin` (parent `default_plugin_manager`).
- Two hooks in `entity_view_mode_field_plugin.module`: `hook_entity_extra_field_info()` and
  `hook_entity_load()`.

## Solution docs
- **Plugin type: annotation, manager, base, and the two hooks (the API to extend)** →
  [plugins/plugin-type.md](plugins/plugin-type.md)
- **The five shipped plugins — IDs, target entity types, and values returned** →
  [plugins/shipped-plugins.md](plugins/shipped-plugins.md)
