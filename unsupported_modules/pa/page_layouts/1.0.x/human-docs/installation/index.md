# Installation

> **Note:** Page Layouts is marked *Unsupported* / *Obsolete* upstream. Only
> install it if you have an existing reason to; prefer a maintained alternative
> for new work.

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) — Drupal enables it automatically as a
  dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/page_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_layouts -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_layouts -y
```

Core's Views module is enabled automatically if it is not already on.

## Verify it worked

Confirm the module is listed as enabled on **Extend** (`/admin/modules`) or via
`drush pm:list --status=enabled | grep page_layouts`.
