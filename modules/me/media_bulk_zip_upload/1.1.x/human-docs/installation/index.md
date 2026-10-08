# Installation

## Requirements

- **PHP 8.1 or newer** (`php: >=8.1`).
- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Media** module (`media`) — Drupal enables it automatically as a
  dependency.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_bulk_zip_upload -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_bulk_zip_upload -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_bulk_zip_upload -y
```

## Verify it worked

Once enabled, go to **Configuration → Media → Media Bulk Zip Upload config**
(`/admin/config/media/media-bulk-zip-upload-config`) — if the settings form loads,
the module is active. Enable a media type there, then confirm the bulk form
appears at `/media/add/{media_type}/bulk`. See
[Configuration](../configuration/index.md) for the details.
