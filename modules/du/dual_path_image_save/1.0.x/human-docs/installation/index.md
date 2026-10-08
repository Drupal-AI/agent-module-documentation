# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Image** (`image`), **Views** (`views`), and **Field** (`field`)
  modules — all part of Drupal core. Drupal enables them automatically as
  dependencies when you turn on Dual Path Image Save.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dual_path_image_save -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dual_path_image_save -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dual_path_image_save -y
```

## Verify it worked

The module does nothing until it is configured, so the real test comes after setup.
Once you have listed a field and set its custom path (see
[Configuration](../configuration/index.md)), save a node that has an image in that
field, then look in the destination directory — you should find a copy of the
uploaded file there, named the same as the original, sitting alongside the untouched
original in its normal location.
