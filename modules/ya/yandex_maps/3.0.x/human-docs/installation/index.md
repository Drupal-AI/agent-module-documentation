# Installation

## Requirements

- **Drupal 11 or newer** (`core_version_requirement: ^11 || ^12 || ^13 || ^14 || ^15`).
- A **Yandex.Maps API key**. Register one in the Yandex developer console; it is a
  public, browser‑side JavaScript key, so tie it to your site's domain there.
- The **[Geofield](https://www.drupal.org/project/geofield)** module. The map
  widget, formatter, and Views style all work on `geofield` geometry, and the module
  uses the geoPHP library (which Geofield provides) to convert between WKT storage
  and the GeoJSON the map understands. Install it alongside Yandex.Maps if it isn't
  already present.
- Core's **Views** module (in core) if you want to use the map Views style.

## Install with Composer

From the project root:

```bash
composer require drupal/yandex_maps -W
```

If Geofield is not yet installed, add it too:

```bash
composer require drupal/geofield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/yandex_maps -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en yandex_maps -y
```

Or enable **Yandex.Maps** from *Extend* (`/admin/modules`).

After enabling, go to **Configuration → System → Yandex.Maps** and enter your API
key before adding any maps — see [Configuration](../configuration/index.md).

## Optional submodule — examples

The project ships a **Yandex.Maps examples** submodule that adds demo routes and
forms illustrating the render element, clustering, and form editing:

```bash
drush en yandex_maps_examples -y
```

Enable it on a development site to learn the API, then disable it before going live.
