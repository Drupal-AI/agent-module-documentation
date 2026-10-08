# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **PHP 8.0 or newer**.
- The **Pathauto** module
  ([`pathauto`](https://www.drupal.org/project/pathauto)) — required.
- The **Token** module
  ([`token`](https://www.drupal.org/project/token)) — required.
- The **URL Entity** module
  ([`url_entity`](https://www.drupal.org/project/url_entity)) — required; its
  purpose is resolving a URL to an entity.

Composer will pull in these contrib dependencies for you with the `-W` flag below.

**Operational requirement:** aliases are regenerated in a **queue**, so your site
must be set up to process queues automatically — for example during cron runs, or
with the *Drush Queue Run All* module. See "How to use it" in the
[overview](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/pathauto_update -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Pathauto, Token,
and URL Entity and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/pathauto_update -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pathauto_update -y
```

Drupal will enable Pathauto, Token, and URL Entity at the same time if they aren't
already on. During installation the module indexes the dependencies of your
existing path aliases — no further configuration is needed.

## Verify it worked

Rename something a pattern depends on — for example a taxonomy term referenced by
one of your Pathauto patterns — then process the queues:

```bash
drush queue:run pathauto_update_path_alias_dependency_updater
drush queue:run pathauto_update_path_alias_updater
```

Check an affected node's alias and confirm it now reflects the new value.
