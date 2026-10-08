# Installation

Installing SQLite 3.37 involves an extra step compared with a normal module,
because it supplies a database driver that has to be wired into your database
settings.

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- Core's **SQLite** driver module (`sqlite`).
- **SQLite 3.37 or newer** available on your system. (If you have SQLite 3.45+,
  prefer core's own driver and skip this module.)

## Step 1 — install with Composer

From the project root:

```bash
composer require 'drupal/sqlite337:^1.0@alpha'
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require 'drupal/sqlite337:^1.0@alpha'`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Step 2 — wire the driver into your database settings

**Installing Drupal from scratch (no existing `settings.php`)?** If you let the
installer write `settings.php` for you, just follow the installer's prompts — it
writes out the database settings this driver needs. There is nothing more to do
here.

**Already have a `settings.php`?** Add this line to your `settings.php`, *after*
the `$databases` variable is defined, so the driver's information is loaded:

```php
require DRUPAL_ROOT . '/modules/contrib/sqlite337/settings.inc';
```

## Step 3 — enable the module

This step is only needed when adding the module to an **existing** site (on a new
install, the Drupal installer already handles it):

```bash
drush en sqlite337 -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

If Drupal loads and operates normally on your SQLite 3.37+ system, the driver is
in use. There is no configuration screen to check — the driver works at the
database‑connection level.
