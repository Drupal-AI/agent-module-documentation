# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core modules **Media** (`media`), **Media Library** (`media_library`), and
  **Text** (`text`) — these ship with Drupal core, and Drupal enables any that
  are off as dependencies.
- Recommended: the base **DSFR theme** and **DSFR Core**, since this module is
  part of the DSFR for Drupal suite (DSFR Core requires it).

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dsfr_twig_components -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed. In most cases this module arrives automatically as a
dependency when you install **DSFR Core**.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dsfr_twig_components -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dsfr_twig_components -y
```

Drupal enables its core dependencies (Media, Media Library, Text) alongside it.

## Verify it worked

Confirm the module appears as enabled on the **Extend** page (`/admin/modules`).
With it in place, the DSFR Twig components are available to DSFR Core, the other
DSFR modules, and your DSFR theme.
