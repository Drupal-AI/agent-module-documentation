# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No other modules are required, and there are no third‑party Composer or PHP
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/home_page_for_roles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/home_page_for_roles -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en home_page_for_roles -y
```

## Verify it worked

Go to **Configuration → People → Homepage by role**
(`/admin/config/people/homepage-roles`). The settings form should load, ready for
you to enter per‑role homepage paths — see [Configuration](../configuration/index.md).
