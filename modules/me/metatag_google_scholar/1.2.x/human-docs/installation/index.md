# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The [Metatag](https://www.drupal.org/project/metatag) module (`metatag`) — Composer pulls
  it in automatically as a dependency. All rendering, token replacement and per‑entity
  overrides are handled by Metatag core; this module only adds the Google Scholar tag group.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/metatag_google_scholar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed (including Metatag).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/metatag_google_scholar -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metatag_google_scholar -y
```

There is no settings form and no submodules. Once enabled, the **Google Scholar** group
appears in the Metatag forms — see [How to use it](../index.md#how-to-use-it).
