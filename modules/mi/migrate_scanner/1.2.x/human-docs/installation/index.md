# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Migrate** module (`migrate`) — the only dependency, enabled
  automatically when you turn on this module.

There are no third‑party Composer or PHP library requirements, and no permissions
or configuration schema.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_scanner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer resolves the module from packages.drupal.org as
usual.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_scanner -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_scanner -y
```

That's all — recursive discovery is active immediately, with nothing to
configure.

## Verify it worked

Put (or move) a migration YAML file into a subdirectory of a module's
`migrations/` folder, then run:

```bash
drush migrate:status
```

The migration that lives in the subdirectory should now appear in the list. If it
does, recursive discovery is working.
