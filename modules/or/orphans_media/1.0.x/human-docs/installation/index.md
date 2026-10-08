# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`) enabled and in use on the site — the only
  dependency, enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/orphans_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/orphans_media -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en orphans_media -y
```

## Grant the permission

The module provides an **access orphans media delete** permission. Because it
deletes media permanently, grant it only to a trusted role under **People →
Permissions** — do not delegate it widely.

## Verify it worked

Log in as a user with the permission and open
`/admin/config/media/orphans-media`. You should see the unused‑media report with a
bundle filter. Before deleting anything, take a backup and confirm the listed
items are genuinely unreferenced.
