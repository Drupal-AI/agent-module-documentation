# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- No other contrib module dependencies. The Select2 JavaScript library itself is
  loaded from a CDN by default, so there's nothing extra to download to get
  started (see below to serve it locally instead).

There are no third-party Composer packages or PHP library requirements declared
by the module.

## Install with Composer

From the project root:

```bash
composer require drupal/select2_all -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/select2_all -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en select2_all -y
```

That's all — there is no configuration. Admin dropdowns are enhanced with
Select2 immediately. See [How to use it](../index.md#how-to-use-it) for opting
individual elements in or out and for serving the Select2 library locally
instead of from the CDN.

## Optional: serve the Select2 library locally

If you don't want to depend on the CDN, place the Select2 distribution under
your Drupal root at `libraries/select2/dist/` (so that
`js/select2.min.js` and `css/select2.min.css` exist there) and rebuild caches
with `drush cr`. The module detects the local copy and uses it automatically.

This module ships no submodules.
