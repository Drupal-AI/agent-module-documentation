# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.2 or newer**.
- The `symfony/finder` library (`^4.4 || ^5.0 || ^6.2 || ^7.0`), which Composer
  installs for you.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/google_webfonts_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including `symfony/finder`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_webfonts_helper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_webfonts_helper -y
```

## Verify it worked

Go to **Configuration → System → Google Webfonts Helper**
(`/admin/config/system/google-webfonts-helper`). If the font management page loads,
the module is installed — next, add a font and attach its library as described in
the main [guide](../index.md).

> **Note:** this is an alpha release (8.x-1.0-alpha14). The module also downloads
> font files to the filesystem, so plan your deployment to either commit or
> re-fetch those files per environment.
