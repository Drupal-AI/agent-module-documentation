# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Media** module (`media`) enabled — the only dependency. Drupal enables it
  automatically as a dependency when you turn on Fallback Media.
- At least one media field and a media item to use as the fallback.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fallback_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fallback_media -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fallback_media -y
```

If core Media is not already enabled, Drupal enables it as a dependency.

## Verify it worked

Go to a bundle's **Manage display** and open the format options for a media field.
The Fallback Media formatter should appear in the format list. Select it, pick a
fallback media item, save, and view an entity whose field is empty — it should now
render the fallback instead of nothing.
