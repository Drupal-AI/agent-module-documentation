# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer packages
  or libraries.
- A site that uses the **database cache backend** — the prefix applies to cache IDs
  written to the database.

## Install with Composer

From the project root:

```bash
composer require drupal/db_cache_prefix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/db_cache_prefix -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en db_cache_prefix -y
```

## Configure the prefix in settings.php

There is no admin form — the prefix is set in your site's `settings.php`. Add:

```php
$settings['db_cache_prefix'] = 'my_prefix';
```

The value can be any string, but it makes most sense to derive it from something
that identifies the instance — for example the deployment ID, the release tag, or
the environment name — so each instance sharing the cache store gets its own scope.

> **Treat a prefix change as a deployment event.** Changing this value invalidates
> the entire cache (a cold start), which is exactly what you want on a fresh
> deployment but not something to toggle casually on a busy production site.

## Verify it worked

After setting the prefix and rebuilding the cache (`drush cr`), the entries written
to the database cache tables should carry your prefix in their cache IDs. On a
setup where two instances previously stepped on each other's cache, confirm that a
change made in one no longer appears in the other.
