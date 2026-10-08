# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/requirement -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/requirement -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en requirement -y
```

## Verify it worked

Go to **Reports → Requirements report** (`/admin/reports/requirements`). The page
should load and list any requirements declared on your site (it may be empty until
a module — possibly your own — declares some). A summary also appears on the
**Status report** at `/admin/reports/status`. See the "How to use it" section of
the [overview](../index.md) for next steps, including how to declare your own
requirements.
