# Installation

## Requirements

- **Drupal 11.3 or newer** (or Drupal 12) — `core_version_requirement: ^11.3 || ^12`.
  (For Drupal 9.5 / 10, use the module's 3.0.x branch instead.)
- Core's **Migrate** module (`migrate`), enabled automatically as a dependency.
- **Drush 9 or newer** (the module conflicts with Drush versions below 9).
- A migration **runner** to actually have a `migrate:import` command — in practice
  **Migrate Tools** (`drupal/migrate_tools`) or Migrate Run.

Recommended companions (from the module's own suggestions):

| Module | Why |
|---|---|
| **Migrate Tools** (`drupal/migrate_tools`) | Provides the `migrate:import` / `migrate:status` commands the debug options attach to. |
| **Migrate Plus** (`drupal/migrate_plus`) | Config-entity migrations; `--migrate-debug` can revert their config so edited YAML is re-read. |
| **Config Update** (`drupal/config_update`) | Required for the config-revert behaviour of `--migrate-debug` to work with Migrate Plus. |

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_devel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This is a development tool, so you may prefer to require it
with `--dev`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/migrate_devel -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_devel -y
```

## Verify it worked

Run a migration with the debug flag and confirm you see the colored per-row dump:

```bash
drush migrate:import <migration_id> --migrate-debug
```

Remember the output only appears on the command line. There is nothing else to
configure — see the [overview](../index.md#how-to-use-it) for the `debug` process
plugin and the two CLI options.
