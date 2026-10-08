# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contributed modules — it works with Drupal core's maintenance page.

## Install with Composer

From the project root:

```bash
composer require drupal/maintenance_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/maintenance_preview -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maintenance_preview -y
```

## Grant the preview permission

The module has no settings form — the only setup step is granting its
permission. Go to **People → Permissions** (`/admin/people/permissions`) and give
the Maintenance Preview permission to the roles that should be able to view the
maintenance page (for example your developer or site-builder role).

## Verify it worked

As a user who holds the preview permission, preview the maintenance page. It
should render without you enabling maintenance mode, and other visitors should
see the site as normal — confirming the preview does not take the site offline.
