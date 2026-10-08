# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- A **Google API key** with the Places API enabled, and the **Google Place ID**
  of the location whose reviews you want to display. You don't need these to
  install, but the blocks render nothing until they are set.

There are no third‑party Composer or PHP library requirements, and no module
dependencies beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/googlereviews -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/googlereviews -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en googlereviews -y
```

Then set your API key and Place ID on the settings page and place the blocks —
see [Configuration](../configuration/index.md).

## A note on the API key

Your Google API key is a secret. Rather than committing it, store it as an
environment variable and override it per environment (for example via
`settings.php` `$config['googlereviews.settings']['google_auth_key']`), so it
never ends up in exported configuration or version control. Consider restricting
the key in the Google Cloud console to the Places API and to your site's referrer.

## Submodules

None — Google Reviews ships as a single module.
