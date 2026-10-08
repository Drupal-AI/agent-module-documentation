<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EDW Migrate D7 (edw_migrate_d7) — agent index

Developer toolkit of reusable **Migrate API plugins** for building Drupal 7 → Drupal 8/9/10/11
migrations. No UI, routes, permissions, services, config, Drush commands or install file — just
plugin classes under `src/Plugin/migrate/**` plus one `.module` hook. You reference its plugins from
your own migration YAML; migrations are run by a trusted operator (Drush / Migrate Tools).

- Package `Migration`. License GPL-2.0-or-later. Version **1.0.0-beta2**. Core `^8.8.0 || ^9.0 || ^10 || ^11`.
- Depends on `migrate`, `migrate_plus`, `migrate_tools`, `migrate_drupal` (info.yml).
- `paragraphs` is needed only if you use the `paragraph_generate` process plugin; `league/csv` only for the `csv` source plugin. Neither is a declared dependency.

## What it actually provides

- **Source plugins** (`src/Plugin/migrate/source/**`): `csv`, plus D7 sources `edw_d7_node`,
  `edw_d7_taxonomy_term`, `edw_d7_taxonomy_term_et`, `edw_d7_taxonomy_term_i18n_translation`,
  `edw_d7_node_entity_translation`, `edw_d7_user`, `edw_d7_file`, `edw_d7_menu_link`,
  `draggableviews`, `d7_locale_source`, `d7_locale_target`, and the shared `EdwSource` trait
  → [plugins/sources.md](plugins/sources.md)
- **Process plugins** (`src/Plugin/migrate/process/**`): `fid_download`, `paragraph_generate`,
  `deepest_value`, `strip_inline_styles` → [plugins/process.md](plugins/process.md)
- **Destination plugins** (`src/Plugin/migrate/destination/d7/**`): `content_access`,
  `edw_draggableviews`, `d7_locale_source`, `d7_locale_target` → [plugins/destinations.md](plugins/destinations.md)
- **The `.module` hook, dependencies and how to run it** → [api/running.md](api/running.md)

## Key facts

- `edw_migrate_d7.module` implements `hook_migration_plugins_alter()`: it **removes** every
  file-discovered migration (has `_discovered_file_path`) and every migration whose `provider`
  contains `migrate_drupal` — i.e. it disables the auto-generated Migrate Drupal migrations so only
  your explicit configs run.
- `provides_config_schema` = false (no `config/`), `provides_permissions` = false,
  `provides_drush_commands` = false. It defines plugin *instances*, not new plugin *types*.
