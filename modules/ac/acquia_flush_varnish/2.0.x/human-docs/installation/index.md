# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An **Acquia-hosted site** — it purges the Acquia platform's Varnish and CDN
  cache, so it is meant for sites running on Acquia.

It has no module dependencies and no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_flush_varnish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_flush_varnish -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_flush_varnish -y
```

## Grant the purge permission

The module provides its **own permission** for triggering a purge. Because a purge
clears the live edge cache, assign it deliberately:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the Acquia Flush Varnish permission.
3. Tick it **only** for roles you trust with a production-affecting action (an
   administrator role, typically), then save.

## Verify it worked

Log in as a user in a role that holds the purge permission and confirm the flush
action is available from the admin. Trigger it once to check it clears the edge
cache as expected.
