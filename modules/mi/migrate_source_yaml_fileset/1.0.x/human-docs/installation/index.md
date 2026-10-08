# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — Drupal enables it automatically as a
  dependency when you turn on this module.

There are no third-party Composer or PHP library requirements.

> This release line is published as an alpha (`1.0.0-alpha3`) and the project is
> minimally maintained — fine for a controlled, one-off migration, but test it
> against your own content before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_source_yaml_fileset -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_source_yaml_fileset -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_source_yaml_fileset -y
```

That's all it takes. There is no configuration form — the `yaml_fileset` source
plugin is now available to any migration definition.

## Verify it worked

Write a small migration that uses `plugin: yaml_fileset` with a `path` pointing at
a folder of YAML files (see the [main guide](../index.md) for an example), then
run `drush migrate:status` to confirm the migration is registered and
`drush migrate:import <migration_id>` to run it.
