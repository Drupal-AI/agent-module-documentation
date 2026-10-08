# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (enabled by default on most sites) if you want to use
  the Muuri Views style plugin.
- No hand‑managed third‑party libraries — the integration provides the Muuri
  JavaScript library.

## Install with Composer

From the project root:

```bash
composer require drupal/muuri -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/muuri -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en muuri -y
```

There is no configuration step — the module simply makes Muuri available.

## Verify it worked

Create or edit a View at **Structure → Views** (`/admin/structure/views`) and
confirm that **Muuri** appears as an available **Format** for the display. Select
it, save, and view the display — the results should render as a responsive Muuri
grid.
