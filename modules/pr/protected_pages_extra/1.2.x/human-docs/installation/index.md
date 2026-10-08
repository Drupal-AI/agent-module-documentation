# Installation

## Requirements

- **Drupal 11.1 or higher** (`core_version_requirement: ^11.1`).
- Core's **Path alias** module (`path_alias`) — enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements. If you use a CDN or
reverse‑proxy cache, a tag‑aware purger (such as the Purge module) is recommended so the
module's cache invalidations are acted on — but it is not required.

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

## Migrating from the legacy Protected Pages module

If the original `protected_pages` module is enabled when you install this one, the
install hook migrates its page entries, settings, and role permissions in a single
step, then suppresses the legacy module's redirect so the two can coexist. Verify the
migrated entities on the overview page, then uninstall the old module:

```bash
drush pmu protected_pages
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Protected Pages Extra**
(`/admin/config/system/protected-pages-extra`). If the overview loads with an option to
add a page protection, the module is installed. See
[Configuration](../configuration/index.md) to create your first protected page.
