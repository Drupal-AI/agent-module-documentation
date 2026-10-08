# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12**
  (`core_version_requirement: ^8 || ^9 || ^10 || ^11 || ^12`).
- Drupal core only — there are no module dependencies and no PHP library
  requirements.

Note that this project is **not covered by Drupal's security advisory policy**, and
it is primarily a developer/debugging aid.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_aggregation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disable_aggregation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_aggregation -y
```

That's all it takes. There is no configuration — from now on, authenticated users
receive un-aggregated CSS and JavaScript, while anonymous visitors keep aggregation.

## Verify it worked

Log in, reload any page, and view the page source or your browser's network panel.
You should see CSS and JavaScript delivered as many individual files rather than a
handful of combined bundles. Viewing the same page while logged out should still
show aggregated assets.
