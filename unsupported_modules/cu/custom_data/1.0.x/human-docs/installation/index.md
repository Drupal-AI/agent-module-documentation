# Installation

> **Before you install:** this module is **discontinued** (*Unsupported / Obsolete*)
> and its maintainers recommend **[Storage
> Entities](https://www.drupal.org/project/storage)** instead. It supports Drupal 9
> and 10 only, not Drupal 11. Only install it if you are maintaining an existing site
> that already uses it.

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The contrib **Entity API** module (`entity`) — Custom Data uses its query‑access
  and permission‑provider handlers. This is a separate Composer package
  (`drupal/entity`) and must be present.
- Core modules **Field**, **Options**, **Text**, and **User** — all part of Drupal
  core and enabled automatically as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_data -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Entity API
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_data -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_data -y
```

Drupal will enable the contrib Entity API module and the required core modules
(Field, Options, Text, User) alongside it.

## Verify it worked

Log in as an administrator and go to **Structure → Custom data types**
(`/admin/structure/custom-data-type`). You should be able to add a type there. See
the main guide's [How to use it](../index.md#how-to-use-it) for the full setup flow.
