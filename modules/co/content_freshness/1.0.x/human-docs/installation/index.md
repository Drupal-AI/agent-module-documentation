# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Node** module (`node`) — enabled by default on a standard site.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_freshness -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_freshness -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_freshness -y
```

## Verify it worked

The badge does not appear until you configure thresholds, enable content types,
and position it on the display. Go to **Configuration → Content → Content Freshness
Indicator** and confirm the settings form loads, then follow
[Configuration](../configuration/index.md). Once set up, view a page of an enabled
content type and you should see the color‑coded freshness badge with its relative
"Updated N days ago" text.
