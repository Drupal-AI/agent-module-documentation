# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

The fix targets core Views, which is part of Drupal. There are no other module
dependencies and no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fix_views_autocomplete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fix_views_autocomplete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fix_views_autocomplete -y
```

There is no configuration step — the route fix takes effect as soon as the module
is enabled.

## Verify it worked

Return to the page that previously threw the `view_args` / "must match `[^/]++`"
error and reload it. The page should now render normally instead of showing the
routing exception, and your Views autocomplete filters should work.
