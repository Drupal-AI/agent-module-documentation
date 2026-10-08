# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- A **Mapbox account** and an access token — see
  [Mapbox access tokens](https://docs.mapbox.com/help/getting-started/access-tokens/).

There are no module dependencies and no third-party Composer or PHP library
requirements — the Mapbox GL JS assets are loaded via the module's own libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/mapbox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mapbox -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mapbox -y
```

## Verify it worked

Go to **Configuration → Web services → Mapbox**
(`/admin/config/services/mapbox`). If the settings form loads, the module is
installed — enter your access token and pick a style, as described in
[Configuration](../configuration/index.md). The page's live preview is a quick way
to confirm your token works.
