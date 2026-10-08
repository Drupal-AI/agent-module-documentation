# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **Google Ads** account with a conversion action set up, so you have a
  conversion ID (and label) to enter.

There are no other module or third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/google_adwords_lite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_adwords_lite -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_adwords_lite -y
```

## Verify it worked

Open the module's settings form (see [Configuration](../configuration/index.md)).
If it loads and accepts your Google Ads conversion details, the module is installed
correctly. After saving, view a front-end page and confirm the Google Ads tracking
snippet appears in the page source.
