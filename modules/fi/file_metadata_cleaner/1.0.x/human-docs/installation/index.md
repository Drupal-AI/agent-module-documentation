# Installation

## Requirements

File Metadata Cleaner needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or higher.**
- Core's **File**, **User**, and **Views** modules.
- The `ahmetburkan/exiftool-binary` Composer package — a cross-platform,
  Composer-distributed build of ExifTool. **Without ExifTool, metadata cleaning
  will not function.**

## Install with Composer

From the project root:

```bash
composer require drupal/file_metadata_cleaner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the ExifTool
binary package and any other dependencies, and update shared packages as needed.
You can confirm the ExifTool binary was pulled in with:

```bash
composer show ahmetburkan/exiftool-binary
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_metadata_cleaner -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_metadata_cleaner -y
```

## Verify it worked

Visit **Configuration → Media → File Metadata Cleaner**
(`/admin/config/media/file-metadata-cleaner`) — you should see the settings form.
To confirm cleaning works end to end, open a supported file's metadata page,
review its metadata table, run **Clean Metadata**, and re-open the page to see the
metadata removed. See [Configuration](../configuration/index.md) for the details.
