# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drush ^11** — the module overrides Drush's migrate commands and expects that
  version.
- No dependent Drupal modules and no third-party PHP library requirements.

Note that at the time of documentation this branch was an alpha release
(`1.0.0-alpha14`); treat it accordingly on production sites.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_migrate_cli -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smart_migrate_cli -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_migrate_cli -y
```

Once enabled, its commands replace the standard Drush `migrate:*` commands
automatically — there is nothing to configure.

## Optional: the Smart Migrate Fixes submodule

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Smart Migrate Fixes** | `smart_migrate_fixes` | Helper utilities that patch and normalise migration definitions. |

Enable it only if you need those definition helpers:

```bash
drush en smart_migrate_fixes -y
```

## Verify it worked

Run `drush list --filter=migrate` and confirm the migrate commands are present.
Because Smart Migrate CLI runs entirely from the command line, its use is limited
to operators who already have Drush/shell access.
