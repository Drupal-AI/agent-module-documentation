# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Link** (`link`) and **File** (`file`) modules — the module's
  dependencies, enabled automatically. Link is part of Drupal core.

There are no third‑party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/file_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_link -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_link -y
```

There is no configuration page. Once enabled, **File Link** becomes available as a
field type when you add a field to any bundle. See the
[overview](../index.md#how-to-use-it) for adding and configuring a File Link field,
and for the two optional `settings.php` flags that tune its HTTP behaviour.
