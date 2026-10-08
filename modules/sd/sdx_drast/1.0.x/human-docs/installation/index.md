# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.3** or newer.
- The **SDX** module (`sdx`) — DRAST builds on SDX and lists it as a dependency.
- A theme configured with `engine: sdx` and framework templates in its `templates/`
  directory.

This is an early release (`1.0.0-alpha3`) — treat it as pre-production and test on a
non-production copy first.

## Install with Composer

Install the SDX module first, then DRAST (Composer will resolve the SDX dependency
for you when you require DRAST):

```bash
composer require drupal/sdx_drast -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sdx_drast -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable SDX DRAST and, optionally, its DataProvider submodule:

```bash
drush en sdx_drast -y
# optional: typed route-level data for admin pages
drush en sdx_data_provider -y
```

## Activate the engine

1. Set `engine: sdx` in your theme's `.info.yml` file.
2. Create framework templates (`.tsx`, `.vue`, or `.svelte`) in the theme's
   `templates/` directory, for example `templates/block/block.tsx`.
3. Rebuild the theme registry:

   ```bash
   drush cr
   ```

A ready-made starting point with common Drupal templates already implemented is
available as **SDX React Base**.
