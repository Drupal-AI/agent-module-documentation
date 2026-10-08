# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The [Toolshed](https://www.drupal.org/project/toolshed) module (`toolshed`) — a
  required dependency. Composer pulls it in with the `-W` flag below.
- A **map provider** module to actually render maps — e.g.
  [Mapkit Google Maps](https://www.drupal.org/project/mapkit_gmap)
  (`mapkit_gmap`). Mapkit alone renders no map.
- **Optional:** [Search API](https://www.drupal.org/project/search_api) if you
  want indexed proximity search via Mapkit's Search API location data type.

## Install with Composer

From the project root:

```bash
composer require drupal/mapkit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
**Toolshed** module and update any shared dependencies as needed. To add the
Google Maps provider at the same time:

```bash
composer require drupal/mapkit drupal/mapkit_gmap -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mapkit -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mapkit -y
```

Then enable a provider, for example:

```bash
drush en mapkit_gmap -y
```

## Verify it worked

Go to **Configuration → Web services → Mapkit**
(`/admin/config/services/mapkit`). You should see the provider listing page. Once
you've enabled and configured a provider, it appears here — continue to
[Configuration](../configuration/index.md).
