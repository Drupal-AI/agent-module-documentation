# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1** or newer.
- Core's **Layout Builder**, **Media Library**, and the **Claro** admin theme —
  this module exists to match Claro specifically, so it only makes sense with
  Claro set as your admin theme.

There are no third-party Composer libraries. Note that the current release is an
**alpha** (`2.0.0-alpha2`); test it and report any bugs.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_claro -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lb_claro -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_claro -y
```

That's all — there is no configuration. Confirm **Claro** is your active admin
theme (**Appearance → Administration theme**) so the overrides apply where they
are meant to.

## Verify it worked

Edit any Layout Builder–enabled entity's layout. The canvas, the off-canvas tray
(now nice and wide), entity forms, and the media library should all match the
Claro admin theme rather than looking like a separate application. If styles look
off after a minor core update, that is the known risk of core renaming a Layout
Builder stylesheet — check for a module update.
