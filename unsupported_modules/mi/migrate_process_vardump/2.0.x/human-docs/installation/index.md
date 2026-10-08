# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- Core's **Migrate** module — you will naturally have it enabled if you are
  writing migrations. The module itself declares no hard module dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_process_vardump -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_process_vardump -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_process_vardump -y
```

Since this is a development aid, enable it on your development or staging
environment while you build migrations, and consider leaving it disabled on
production.

## Verify it worked

Add a `vardump` step to a migration's process pipeline (see the
[overview](../index.md#how-to-use-it)) and run `drush migrate:import`. You should
see the value dumped to the terminal for each row processed.
