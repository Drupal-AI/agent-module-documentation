# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Core's **Breakpoint** module (`breakpoint`), which this module depends on —
  Drupal enables it automatically as a dependency.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/breakpoints_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/breakpoints_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en breakpoints_ui -y
```

This also enables core Breakpoint if it is not already on. Once enabled, view the
overview at **Configuration → Media → Breakpoints**
(`/admin/config/media/breakpoints`).

> **Access reminder:** the overview uses the core *Access content* permission,
> which anonymous users have by default, so the listing is effectively public. It
> exposes only breakpoint metadata read from code, but if that is not acceptable
> for your site, tighten the permission or restrict the path. See the
> [overview](../index.md#a-note-on-access).
