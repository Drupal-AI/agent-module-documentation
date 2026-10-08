# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Field** (`field`) and **Field UI** (`field_ui`) modules, which
  Breakpoint Field depends on — Drupal enables them automatically as
  dependencies.
- No third-party Composer or PHP library requirements.
- The breakpoints it offers come from your installed themes' and modules'
  `*.breakpoints.yml` files, so a theme that declares breakpoints is what makes
  the field useful.

## Install with Composer

From the project root:

```bash
composer require drupal/breakpoint_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/breakpoint_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en breakpoint_field -y
```

This also enables core Field and Field UI if they are not already on. There is no
settings page — add a Breakpoint Field to a content type through the **Field UI**
(Structure → your content type → Manage fields → Add field) and configure it
there. See the [overview](../index.md#how-to-use-it).
