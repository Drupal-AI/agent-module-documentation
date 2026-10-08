# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- **PHP 7.3** or newer.
- A substantial set of contrib and core module dependencies, all installed
  automatically by Composer:
  - [Address](https://www.drupal.org/project/address) (`address`)
  - [Entity Print Views](https://www.drupal.org/project/entity_print)
    (`entity_print_views`) — for PDF export
  - [Computed Field](https://www.drupal.org/project/computed_field)
    (`computed_field`)
  - [Field Group](https://www.drupal.org/project/field_group) (`field_group`)
  - [Auto Entity Label](https://www.drupal.org/project/auto_entitylabel)
    (`auto_entitylabel`)
  - Core: Menu UI, Node, User, Text, Datetime, Taxonomy

> This project is **not** covered by Drupal's security advisory policy — evaluate
> accordingly before production use.

## Install with Composer

Installing via Composer is important here, because it resolves the full
dependency tree for you:

```bash
composer require drupal/catalogus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/catalogus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en catalogus -y
```

Drupal will enable all of the dependencies listed above at the same time.

## Verify it worked

After enabling, visit **Configuration → Content authoring → Catalogus**
(`/admin/config/content/catalogus`) and confirm the settings form loads (see
[Configuration](../configuration/index.md)). You should also see the **people**
and **community** content types available under **Structure → Content types**.
