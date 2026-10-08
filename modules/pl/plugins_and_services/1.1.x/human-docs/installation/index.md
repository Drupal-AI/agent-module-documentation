# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No other Drupal module dependencies, and no third‑party Composer or PHP library
  requirements.
- The **"What does it do?"** helper performs an outbound Google search, so that
  feature needs internet access from the site.

## Install with Composer

From the project root:

```bash
composer require drupal/plugins_and_services -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plugins_and_services -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plugins_and_services -y
```

## Grant access

The browser pages are protected by the permission the module provides. At
**People → Permissions** (`/admin/people/permissions`), grant it to the roles —
typically administrators or developers — that should be able to browse plugins and
services.

## Verify it worked

Go to **Administration → Reports** (`/admin/reports`). You should see new pages
for browsing plugins by manager and services, each listing classes with their
functions and documentation comments.
