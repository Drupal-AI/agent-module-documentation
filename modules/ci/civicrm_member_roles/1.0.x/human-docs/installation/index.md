# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **CiviCRM**, installed and integrated with your Drupal site via the
  [CiviCRM](https://www.drupal.org/project/civicrm) (`civicrm`) module. This is a
  hard dependency — the sync loads membership data straight from CiviCRM, and if
  CiviCRM can't bootstrap from Drupal the sync won't run.

The release documented here is **`8.x-1.0-rc1`** (a release candidate). There are
no additional Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/civicrm_member_roles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (CiviCRM itself has its own, more involved installation —
follow the CiviCRM project's instructions to get it running before you rely on
this module.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/civicrm_member_roles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en civicrm_member_roles -y
```

Drupal will require the `civicrm` module to be enabled first.

## What to do next

Enabling the module doesn't sync anything yet — you need to create at least one
**association rule** mapping a membership type and statuses to a Drupal role. See
[Configuration](../configuration/index.md).
