<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Magician (migmag) — agent index

A migration developer toolset. The **base `migmag` module has no config, no admin UI, no
plugins, and no services** — it is a set of static PHP helpers + a trait used by the submodules
and by your own migration code. All real features live in the independently-enableable
submodules.

- **Static utility helpers (array/pipeline editing, lookup rewriting, source instantiation)** →
  [api/utilities.md](api/utilities.md)

## Submodules (each has its own docs directory)

| Submodule | What it does |
|---|---|
| `migmag_process` | Extra migrate **process plugins** (`migmag_lookup`, `migmag_try`, `migmag_compare`, `migmag_target_bundle`, `migmag_get_entity_property`, `migmag_uuid_generate`, `migmag_logger_log`) + the `migmag_process.lookup.stub` service. |
| `migmag_process_lookup_replace` | Forces core's `migration_lookup` process plugin to use `MigMagLookup`. |
| `migmag_rollbackable` | Rollback-capable **destination plugins** (`migmag_rollbackable_*`) + 2 DB tables. |
| `migmag_rollbackable_replace` | Swaps core destinations (`config`, `color`, …) for the rollbackable classes without editing YAML. |
| `migmag_menu_link_migrate` | Fixes core menu-link migrations to migrate as many links as possible. |
| `migmag_callback_upgrade` | Backports core 9.2's `callback` process plugin to older cores — **no-op on 9.2+ / Drupal 11**. |

Key facts:
- No `configure` route, no config schema, no permissions, no Drush.
- On this Drupal 11 site the core **migration** plugin manager (`plugin.manager.migration`)
  cannot enumerate definitions (unrelated pathauto issue), but the **process** and
  **destination** plugin managers work — inspect migmag plugins there.
