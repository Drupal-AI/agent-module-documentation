# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules, PHP extensions, or third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/nameday_skhu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nameday_skhu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nameday_skhu -y
```

## Verify it worked

Go to **Structure → Block layout**, click **Place block**, and confirm the Slovak
and Hungarian nameday block(s) are available to place. Once placed, a block
should display the name day for the current date.

For block placement and the developer service, see
[How to use it](../index.md#how-to-use-it).
