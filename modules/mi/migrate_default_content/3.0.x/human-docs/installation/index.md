# Installation

## Requirements

- **Drupal core 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Drupal core's **Migrate** module (`migrate`).
- The **Migrate Source YAML** module (`drupal/migrate_source_yaml ^1.4`), which
  provides the YAML source plugin the generated migrations use.
- **Drush 12 or 13** (`drush/drush ^12 || ^13`) — the module ships Drush commands
  and you import content with Drush. You'll typically also want **Migrate Tools**
  (`drupal/migrate_tools`) for the standard `migrate:import` / `migrate:rollback`
  commands.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_default_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies, including Migrate Source YAML. If you don't already have Migrate
Tools, add it too:

```bash
composer require drupal/migrate_tools -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_default_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_default_content -y
```

This enables Migrate and Migrate Source YAML if they aren't already on.

## Submodule — enable if you need it

The optional **Migrate Default Content Export** submodule adds a Drush command to
generate content YAML from existing site content:

```bash
drush en migrate_default_content_export -y
```

## Next steps

Create your `default_content` directory and YAML files, optionally adjust the
directory settings, and run the migrations — see the
[overview](../index.md#how-to-use-it) for the full walk‑through.
