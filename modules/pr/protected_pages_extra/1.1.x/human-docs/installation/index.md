# Installation

## Requirements

- **Drupal 11.1 or higher** (`core_version_requirement: ^11.1`).
- Core's **Path alias** module (`path_alias`) — enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/protected_pages_extra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/protected_pages_extra -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en protected_pages_extra -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Content authoring → Protected
Pages Extra** (`/admin/config/content/protected-pages-extra`). If the management page
loads with an **Add page protection** button, the module is installed. See
[Configuration](../configuration/index.md) to create your first protected page.

> **Migrating from the original Protected Pages module?** The project README documents a
> comprehensive migration path — consult it before switching a live site.
