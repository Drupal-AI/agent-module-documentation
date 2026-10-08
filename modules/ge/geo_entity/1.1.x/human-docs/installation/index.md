# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Text**, **Views** modules (enabled as dependencies).
- A number of **contrib modules**, all pulled in by Composer:
  **Address**, **Entity Browser** (+ its Entity Browser Entity Form submodule),
  **Geocoder**, **Geofield**, **Inline Entity Form**, **Leaflet**, and **Token**.
- Two **PHP geocoder libraries** installed automatically:
  `geocoder-php/nominatim-provider` and `geocoder-php/photon-provider`.

This is a heavier install than most modules on account of the mapping/geocoding
stack — Composer handles the whole dependency tree for you.

## Install with Composer

From the project root:

```bash
composer require drupal/geo_entity -W
```

The `-W` (`--with-all-dependencies`) flag is important here: it lets Composer pull
in Address, Geocoder, Geofield, Leaflet, Entity Browser, Inline Entity Form, Token,
and the two geocoder PHP libraries, updating shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/geo_entity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geo_entity -y
```

The base module gives you the `geo_entity` entity type, the admin surfaces, the
Entity Browser reuse library, and default view/form modes — but **no concrete
bundles**. The ready-made *address* and *area* bundles come from the submodules
below.

## Submodules — enable the ones you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Geo Entity Address** | `geo_entity_address` | A point + postal-address bundle with an address-autocomplete widget that geocodes typed addresses into structured address + coordinates. |
| **Geo Entity Area** | `geo_entity_area` | A polygon/area bundle backed by a geo-file field (import GPX, KML, GeoJSON, or generic geo files) with file-based geocoder providers. |
| **Geo Entity TZ** | `geo_entity_tz` | Populates a Time Zone field automatically from a location's coordinates using the GeoNames web service. |

For example, to get the common address bundle:

```bash
drush en geo_entity_address -y
```

Each submodule requires the base Geo Entity module, which is already present once
installed above.

## After enabling — a security note

On install the base module grants **View geo** to both the anonymous and
authenticated roles (mirroring core Media), so stored locations are world-viewable
by default. If your site stores non-public locations, revoke *View geo* from the
anonymous role — see [Configuration](../configuration/index.md#permissions).
