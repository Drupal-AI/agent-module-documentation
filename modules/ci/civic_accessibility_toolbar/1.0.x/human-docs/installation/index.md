# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies beyond core, and no third-party libraries — the toolbar
  uses core's jQuery and ships its own CSS and templates.
- For the text-resize buttons to actually change text size, your active theme's
  typography must be expressed in **`rem`/`em`** units (see
  [Configuration](../configuration/index.md)).

## Install with Composer

Note the Composer namespace is `civic/civic_accessibility_toolbar`. From the
project root:

```bash
composer require civic/civic_accessibility_toolbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require civic/civic_accessibility_toolbar -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en civic_accessibility_toolbar -y
```

There are no submodules and no permissions to set. Once enabled, place the
**Accessibility Toolbar** block — see [Configuration](../configuration/index.md).
