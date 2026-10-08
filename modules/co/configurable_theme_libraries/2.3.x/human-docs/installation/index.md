# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules, PHP extensions, or third‑party libraries are required.

To actually get value from it you also need a **theme that defines configurable
libraries** in its `.info.yml` — see "How to use it" in the
[overview](../index.md). Without those definitions the module has nothing to
expose.

## Install with Composer

From the project root:

```bash
composer require drupal/configurable_theme_libraries -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/configurable_theme_libraries -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en configurable_theme_libraries -y
```

## Verify it worked

Enable the module, then define at least one `configurable-libraries` entry in your
active theme's `.info.yml` (see the [overview](../index.md)). Clear caches, then
open **Appearance → Settings → *(your theme)***. You should see your defined
library sets available as options on the theme settings form. Selecting one and
saving changes which assets load on the front end.
