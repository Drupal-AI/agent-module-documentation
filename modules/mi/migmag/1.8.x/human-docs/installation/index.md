# Installation

## Requirements

Migrate Magician is a developer toolset that sits on top of core's Migrate system.
It needs:

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 ||
  ^11`).
- Core's **Migrate** system in play — that is the whole point of the module. The
  base module has no hard module dependencies of its own.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migmag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migmag -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migmag -y
```

Enabling the base module gives you the static helper library. On its own it has no
admin UI, no settings, no permissions, and no Drush commands — it does nothing
visible until your migration code (or a submodule) calls on it.

## Submodules — enable only what you need

The real functionality lives in independently‑enableable submodules. Turn on each
one with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Process plugins** | `migmag_process` | Extra migrate process plugins — `migmag_lookup`, `migmag_try`, `migmag_compare`, `migmag_target_bundle`, `migmag_get_entity_property`, `migmag_uuid_generate`, `migmag_logger_log` — plus an improved migrate‑stub service. |
| **Lookup replace** | `migmag_process_lookup_replace` | Forces core's `migration_lookup` process plugin to use the smarter `MigMagLookup`. |
| **Rollbackable** | `migmag_rollbackable` | Rollback‑capable versions of core destination plugins (config, color, theme settings, display components), backed by two database tables. |
| **Rollbackable replace** | `migmag_rollbackable_replace` | Swaps the core destinations for the rollbackable ones across every migration without editing any YAML. |
| **Menu link migrate** | `migmag_menu_link_migrate` | Fixes core's menu‑link migrations so as many links as possible migrate. |
| **Callback upgrade** | `migmag_callback_upgrade` | Backports core 9.2's `callback` process plugin (with `unpack_source`) to Drupal 8.x / 9.0–9.1 sites. **No‑op on 9.2+ and Drupal 11.** |

For example, to add the extra process plugins:

```bash
drush en migmag_process -y
```

Each submodule works on its own and depends on the base `migmag` module, which is
already present once you have installed it above.
