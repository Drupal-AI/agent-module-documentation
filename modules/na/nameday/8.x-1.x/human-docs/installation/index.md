# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other modules, PHP extensions, or third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/nameday -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nameday -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nameday -y
```

## Verify it worked

Go to **Structure → Block layout**, click **Place block** in any region, and
confirm the **Name day** block is available. Once placed, it should display the
current name day for the site's active language.

For placement details, see [How to use it](../index.md#how-to-use-it).
