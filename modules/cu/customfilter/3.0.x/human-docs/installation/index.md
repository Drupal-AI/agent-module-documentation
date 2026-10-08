# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Filter** module (`filter`) enabled — this is the only dependency, and it's
  part of core (Drupal enables it automatically).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/customfilter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/customfilter -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en customfilter -y
```

There are no submodules.

## A word about permissions

The module adds one permission, **Administer customfilter**, marked *restrict access*
(Drupal warns when you grant it). Because defining a rule is effectively authoring raw
HTML or PHP that runs when content is rendered, grant it only to administrators you'd
also trust with the *Administer filters* permission or a PHP/Full‑HTML text format.
See [Configuration](../configuration/index.md) for the details.
