# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Crop API** module (`drupal/crop` `^2.2`) — a hard dependency; the effect
  builds on it and stores crop entities through it.
- Core's **Image** and **User** modules (enabled in a standard install; pulled in
  as dependencies).

There are no additional third-party PHP libraries. To have crop types like
**Focal Point** available you would install that module separately, but the
default `automated_crop_default` provider works with any crop type.

## Install with Composer

From the project root:

```bash
composer require drupal/automated_crop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Crop module
alongside it and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/automated_crop -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en automated_crop -y
```

This enables the module together with the Crop, Image and User dependencies. Next,
add the Automated Crop effect to an image style — see
[Configuration](../configuration/index.md).
