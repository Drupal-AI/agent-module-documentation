# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **Mapbox account** and a public (`pk.`) access token — see
  [Mapbox access tokens](https://docs.mapbox.com/help/getting-started/access-tokens/).
- Mapbox GL JS/CSS are loaded from the Mapbox CDN (`//api.mapbox.com`) via the
  module's attached library, so the front end needs outbound access to that CDN.

There are no module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mapbox_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mapbox_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mapbox_ui -y
```

## Verify it worked

Go to `/admin/config/mapbox_ui/config` (note: use this path, not the
`/admin/config/mapbox/config` path the README mentions — that one is stale). If
the settings form loads, the module is installed — enter your token and map
options, then place the block, as described in
[Configuration](../configuration/index.md).
