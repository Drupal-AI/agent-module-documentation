# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no additional Composer library, PHP, or module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/google_image_sitemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_image_sitemap -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_image_sitemap -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Google Image Sitemap** — the settings
form should load, listing your content types to choose from. Continue to
[Configuration](../configuration/index.md) to select content types and generate the
sitemap.
