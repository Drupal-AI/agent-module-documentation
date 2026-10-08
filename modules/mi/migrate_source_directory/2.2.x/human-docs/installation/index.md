# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — the only dependency, enabled
  automatically when you turn on this module.
- Read access from the web server to the directory (or directories) you want to
  import from.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_source_directory -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_source_directory -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.
> Remember that the paths in `directory:` are paths *inside* the container.

## Enable the module

```bash
drush en migrate_source_directory -y
```

## Verify it worked

Write a migration using `plugin: directory` (see the
[overview](../index.md#how-to-use-it)) pointed at a small test folder, then run:

```bash
drush migrate:status
```

The migration's total row count should match the number of files the plugin finds
in that directory (after any `file_mask` filtering). Run `drush migrate:import` to
bring the files in.
