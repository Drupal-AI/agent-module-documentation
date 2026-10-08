# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or higher**.
- No external dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/dga_rating -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dga_rating -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dga_rating -y
```

Then clear the cache so the new block is registered:

```bash
drush cr
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm the
**DGA Rating Widget** block is available to place. Add it to a region, then visit
a page in that region — you should see the star rating widget with its average
and review count. See the "How to use it" section of the
[overview](../index.md#how-to-use-it) for placement details.
