# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 7.1** or newer.
- No other module dependencies and no third-party Composer libraries. It uses core's
  image toolkit and image styles.

## Install with Composer

From the project root:

```bash
composer require drupal/image_style_on_upload -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_style_on_upload -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_style_on_upload -y
```

Enabling the module also installs the optional **upload** image style (scale to
2000px wide) that it uses by default. Review the settings at **Configuration → Media
→ Image Style On Upload** to confirm the applied style and the file types it acts on
— see [How to use it](../index.md#how-to-use-it).

> **Heads up:** this module replaces the stored original image file with the styled
> version at upload time. The change is permanent, so pick a style that preserves the
> quality and dimensions you need before you start uploading.
