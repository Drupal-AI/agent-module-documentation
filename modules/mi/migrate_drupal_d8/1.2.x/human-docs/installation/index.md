# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Migrate** module (`migrate`), which Drupal enables as a dependency.
  This is the only dependency the module declares.
- In practice you will also want **Migrate Plus** and **Migrate Tools** to define
  and run migrations, since this module only supplies a source plugin — it does not
  run migrations itself.
- Access to the **source** Drupal 8+ site's database, reachable from the machine
  running the migration.
- No extra Composer libraries or PHP-version requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_drupal_d8 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To install the tooling most migrations use alongside it:

```bash
composer require drupal/migrate_plus drupal/migrate_tools -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_drupal_d8 -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_drupal_d8 -y
```

There are no submodules and no configuration form. Once enabled, the `d8_entity`
source plugin is available to reference from your migration YAML. See the
[overview](../index.md) for how to declare the source database and write a
migration.
