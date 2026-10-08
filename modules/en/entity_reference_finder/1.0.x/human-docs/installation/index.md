# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No third‑party Composer packages or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_finder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_finder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_finder -y
```

## Grant the permission

This module provides its own permission. Go to **People → Permissions**
(`/admin/people/permissions`) and grant it to the roles that should be able to
run the reference report.

## Verify it worked

Visit **Reports → Entity Reference Finder**
(`/admin/reports/entity_reference_finder`). You should reach a page where you can
choose an entity type and bundle and see which reference fields — and the content
types they live on — are configured to point at it.
