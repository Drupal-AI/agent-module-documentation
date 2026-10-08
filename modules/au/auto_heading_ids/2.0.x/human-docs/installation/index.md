# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

The module has no other module dependencies and no third-party Composer library
requirements. Note the current release is `2.0.0-beta3`, a **beta**.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_heading_ids -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_heading_ids -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_heading_ids -y
```

Enabling the module makes the filter available, but it does nothing until you add
it to a text format. Go to **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`), configure the relevant format(s),
and tick the Auto heading ids filter — see the "How to use it" section of the
[overview](../index.md).
