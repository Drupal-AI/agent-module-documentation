# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled.
- The **`maennchen/zipstream-php`** PHP library (`^2.0 || ^3.0`) — used to stream
  multi-contact exports as a ZIP. Composer installs it as a dependency; the module
  reports an error on the status page if it is missing.

## Install with Composer

From the project root:

```bash
composer require drupal/views_vcards -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch the ZipStream
library and update any shared dependencies as needed. Because ZipStream is pulled
in automatically by Composer, you don't need to install it separately.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_vcards -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_vcards -y
```

## After enabling

The module adds **vCard** display, style, and row plugins to Views. Nothing
exports until you build a View with a vCard display and map your fields — see
[How to use it](../index.md#how-to-use-it) in the overview. Also remember to keep
**Twig debugging off**, or the exported cards will be corrupted.
