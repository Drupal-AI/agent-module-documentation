# Installation

## Requirements

Homepage Swap is lightweight:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No other Drupal modules and no third‑party Composer or PHP libraries are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/homepage_swap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/homepage_swap -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en homepage_swap -y
```

## Verify it worked

Log in as an administrator and look for **Homepage Swap** under **Configuration**,
and a **Swap Homepage** link under **Content** (`/admin/content/swap_homepage`).
Before you can swap anything, open the settings page and choose which content
types are eligible — see [Configuration](../configuration/index.md).
