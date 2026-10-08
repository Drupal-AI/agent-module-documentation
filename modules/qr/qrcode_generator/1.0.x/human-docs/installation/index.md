# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **`chillerlan/php-qrcode`** PHP library (`^4.3`) — this module is strictly
  dependent on it, and it is pulled in when you install with Composer.
- The libraries also load **Font Awesome CSS from a CDN** (cdnjs) for the icon —
  an external asset dependency to be aware of.

> **Note:** this project is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/qrcode_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and brings in the `chillerlan/php-qrcode` library. Installing with Composer is the
reliable way to get that library in place.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/qrcode_generator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en qrcode_generator -y
```

## Verify it worked

1. Confirm the module is enabled: `drush pm:list --status=enabled | grep qrcode_generator`.
2. Visit `/admin/qr-page/config` to confirm the settings form loads (you need
   **Administer site configuration**), then continue to
   [Configuration](../configuration/index.md) to set the icon style and place the
   block.
