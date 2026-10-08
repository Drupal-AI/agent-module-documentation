# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No contrib module dependencies, third‑party Composer packages, or external
  libraries — it relies only on Drupal core (it reports on core node content).

> **Security coverage:** this project is **not covered** by Drupal's security
> advisory policy at the time of writing. Weigh that against your site's needs
> before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/content_type_audit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_type_audit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_type_audit -y
```

## Verify it worked

Go to **Reports → Content Type Audit** (`/admin/reports/content-type`). You
should see a table listing every content type with its node count, including
types that currently have zero nodes. Try the published/unpublished and
created‑date filters, and click a type to confirm it opens the Content Overview
filtered to that type.
