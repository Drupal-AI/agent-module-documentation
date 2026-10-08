# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11.0`).
- **PHP 8.2 or newer**.
- Three Composer libraries, pulled in automatically when you require the module:
  - `league/flysystem` (`^1.0.3`)
  - `league/flysystem-replicate-adapter` (`~1.0`)
  - `codementality/flysystem-stream-wrapper` (`^1.1.2`)
- For the **FTP** driver, the PHP `ftp` extension must be present on the server.
- For cloud backends (S3, SFTP, GCS, Dropbox, …), install the matching contrib
  adapter module separately — for example `drupal/flysystem_s3`.

## Install with Composer

From the project root:

```bash
composer require drupal/flysystem -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Flysystem libraries above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/flysystem -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flysystem -y
```

There are no submodules bundled with the base module (cloud adapters are separate
contrib modules).

## Grant the permission

The Sync and Field-migration admin forms are gated by the **Administer flysystem**
permission. Assign it to a trusted role at **People → Permissions**.

## Next: declare a scheme

Enabling the module alone does nothing visible — you must declare at least one
scheme in `settings.php` and rebuild caches. See
[Configuration](../configuration/index.md).

## Verify it worked

After declaring a scheme and running `drush cr`, open the **Status report**
(`/admin/reports/status`) — Flysystem runs each scheme's health check there and
reports whether the backend is reachable.
