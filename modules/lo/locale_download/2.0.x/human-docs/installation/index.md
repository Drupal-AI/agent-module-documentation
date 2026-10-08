# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- A working Drush and a configured local translations directory (Drupal's
  standard interface‑translation setup).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/locale_download -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/locale_download -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en locale_download -y
```

## Verify it worked

Confirm the Drush command is available:

```bash
drush list | grep 'locale:download'
```

Then run `drush locale:download` and check that missing `.po` files appear in
your site's translations directory.
