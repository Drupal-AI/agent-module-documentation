# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Simplenews** module (`simplenews`), version **^4.0**. Simplenews Stats
  follows Simplenews's branch number, so use the same branch for both — this 4.0.x
  release goes with Simplenews 4.x.
- **Database:** this release is effectively MySQL/MariaDB-only at present; it does not
  instantiate cleanly on PostgreSQL or SQLite.
- No additional PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/simplenews_stats -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Simplenews if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simplenews_stats -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simplenews_stats -y
```

## After enabling

- Visit **Content → Simplenews Stats** (`/admin/content/simplenews-stats`) to confirm
  the overview loads.
- Under **People → Permissions**, grant the Simplenews Stats permissions to the right
  roles (see the [main guide](../index.md) for what each one does).
- Before you send tracked newsletters, make sure your privacy notice and lawful basis
  cover open/click tracking — this is personal-data processing.

Remember this is a **beta** release (`4.0.0-beta3`); test it before relying on it in
production.
