# Installation

## Requirements

PHP Warnings & Errors needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Database Logging** module (`dblog`) — this is the only dependency, and
  it is where the block reads its warnings from. Drupal enables it automatically
  as a dependency when you turn on this module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/phpwarnings -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phpwarnings -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phpwarnings -y
```

## Verify it worked

After enabling, go to **Structure → Block layout** and place the **PHP Warnings
& Errors** block in a region (see the "How to use it" section of the
[overview](../index.md)). Load a page that has generated a PHP notice or warning,
and the block should list it. Remember this is a development tool — disable or
remove the block before going live.
