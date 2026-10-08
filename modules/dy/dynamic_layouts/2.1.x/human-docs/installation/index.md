# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Discovery** (`layout_discovery`) and **System** (`system`) modules
  — Layout Discovery is enabled automatically as a dependency.
- **A module that consumes layouts** to actually put your layouts to use — Display
  Suite, Panels, or the core Layout Builder (or any other project that consumes
  layouts).
- **If you choose the Bootstrap (v4) frontend library:** install the **Bootstrap
  Library** module and select the v4 version, and make sure Bootstrap (v4) is
  implemented in your (custom) theme so the grid classes render correctly.

There are no third‑party PHP library requirements. The module ships its own built
admin assets (a `gulpfile.js`/`package.json` front‑end build produces them; the
release includes the built files).

## Install with Composer

From the project root:

```bash
composer require drupal/dynamic_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynamic_layouts -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynamic_layouts -y
```

## Verify it worked

Go to **Configuration → Dynamic Layouts** (`/admin/config/dynamic-layouts`) and
confirm the layout manager loads. Create a simple layout, then open Display Suite,
Panels, or a Layout Builder section and confirm your new layout appears in the list of
available layouts.
