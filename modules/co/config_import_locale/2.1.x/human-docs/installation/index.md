# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Three core modules, all of which Drupal enables automatically as dependencies:
  **Language** (`language`), **Interface Translation** (`locale`), and
  **Configuration Manager** (`config`).

There are no third‑party Composer or PHP library requirements. The module only
makes sense on a multilingual site that has interface translations to protect.

## Install with Composer

From the project root:

```bash
composer require drupal/config_import_locale -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_import_locale -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_import_locale -y
```

## Clear caches — important

Because this module replaces two core services, Drupal must rebuild its service
container before the change is active:

```bash
drush cr
```

Skip this step and the module appears enabled but does nothing. After the cache
rebuild, head to [Configuration](../configuration/index.md) to choose your
translation-overwrite policy.
