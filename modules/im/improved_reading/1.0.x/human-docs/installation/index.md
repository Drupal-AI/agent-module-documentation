# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements. This release is **1.0.0‑beta3** (a beta), and the module is **not
covered by Drupal's security advisory policy** — review it before using it on a
sensitive site.

## Install with Composer

From the project root:

```bash
composer require drupal/improved_reading -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/improved_reading -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en improved_reading -y
```

## Verify it worked

After enabling, follow [Configuration](../configuration/index.md) to grant the use
permission, turn on the effect in the settings form, and place the toggle button
block. Then load a page as a visitor, click the toggle, and confirm the leading
letters of words become bolder.
