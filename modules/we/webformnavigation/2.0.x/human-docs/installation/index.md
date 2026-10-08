# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contrib **Webform** module (`drupal/webform ^5.16 || ^6.0`) and its
  **Webform Submission Log** submodule (`webform_submission_log`) — both required.
  Composer installs Webform for you; enable the Submission Log submodule (it is
  enabled as a dependency).
- There are no other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webformnavigation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Webform if it isn't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/webformnavigation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webformnavigation -y
```

Drupal enables Webform and its Submission Log submodule alongside it if they are
not already on.

## After enabling

There is no global settings page and no permissions of its own. Webform
Navigation is switched on **per webform** — enable it on each wizard form you want
it on, as described in [Configuration](../configuration/index.md).
