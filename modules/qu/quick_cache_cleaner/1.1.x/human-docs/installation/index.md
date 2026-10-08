# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no contrib‑module or PHP‑library dependencies — it only calls
cache‑clearing functions that Drupal core already provides.

## Install with Composer

From the project root:

```bash
composer require drupal/quick_cache_cleaner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quick_cache_cleaner -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quick_cache_cleaner -y
```

## Grant the permission

At **People → Permissions** (`/admin/people/permissions`), grant the module's
cache‑clear permission to the roles that should be allowed to flush caches. Keep this
to trusted administrators and editors — clearing caches is privileged and briefly
slows the site while caches rebuild.

## Verify it worked

Log in as a user who has the permission and look in the administration menu for the
cache‑clear item. Click it — the core and Views caches are cleared and you are
returned to the admin menu. There is nothing further to configure.
