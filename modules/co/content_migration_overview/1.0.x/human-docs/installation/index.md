# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Migrate Drupal** module (`migrate_drupal`) — the module builds on
  Drupal's migration framework, and Drupal will enable it automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_migration_overview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_migration_overview -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_migration_overview -y
```

## Verify it worked

Once enabled, the module exposes the `drush migration:stat` (alias `drush mstat`)
command. Before it can report anything useful, tell it how to reach your source
database — see [Configuration](../configuration/index.md). After that, running
`drush mstat` should print a migration summary with total, passed, and failed
counts and the path to a generated report.
