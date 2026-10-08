# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- A configured **private file system**. Only downloads served through the private
  file stream are tracked — public files are not counted.

There are no additional Composer or PHP library dependencies.

## Install with Composer

The project's on-disk name is long, but the Composer package name is what you
install. From the project root:

```bash
composer require drupal/private_file_download_statistics_and_export_the_data -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/private_file_download_statistics_and_export_the_data -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The machine name you enable is **`file_download_user_track_export`**, not the long
directory name:

```bash
drush en file_download_user_track_export -y
```

## Post-install: you must configure it

Tracking does **not** start until you tell the module which private file field to
watch. Head straight to [Configuration](../configuration/index.md) and set the
private file field name (and, if you want CSV export, the user fields to include).

## Verify it worked

1. Complete the [Configuration](../configuration/index.md) step.
2. Log in as a non-admin test user and download a file from the configured
   private file field.
3. Visit the dashboard at `/admin/files/statistics` — the file should now appear
   with a download count and the downloading user's email and timestamp.

Remember that downloads by user 1 are never counted, so test with a different
account.
