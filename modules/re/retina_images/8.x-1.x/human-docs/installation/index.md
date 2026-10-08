# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — Drupal enables it automatically as a
  dependency when you turn on Retina Images.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/retina_images -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/retina_images -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en retina_images -y
```

## Verify it worked

Go to **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`) and edit an image style. The core image
effects can now output high-resolution (2x) variants for high-DPI displays. See
"How to use it" on the [overview page](../index.md) for how to apply it to a
style.
