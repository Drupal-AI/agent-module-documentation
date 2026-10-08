# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Field** module (`field`) — enabled automatically as a dependency.

The base module has no third‑party Composer libraries. Individual submodules may
add their own requirements — for example `geolocation_geocodio` needs
`geocodio/geocodio-library-php` and `geolocation_gpx` needs `sibyx/phpgpx` — and
map providers such as Google, HERE, Baidu, and Yandex need an **API key** from
that provider.

## Install with Composer

From the project root:

```bash
composer require drupal/geolocation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geolocation -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geolocation -y
```

This gives you the `geolocation` field type and the plugin framework — but on its
own it can render only plain coordinates. To show an actual map you also need at
least one **map-provider submodule** (below).

## Submodules — enable only what you need

All submodules require the base `geolocation` module. Enable the map provider(s)
and integrations you need with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Google Maps** | `geolocation_google_maps` | Google Maps provider, geocoders, and per-country formatting. Has its own settings page for the **API key** (`geolocation_google_maps.settings`). |
| **Leaflet** | `geolocation_leaflet` | Open-source Leaflet provider using open tile layers — **no API key required** — plus Nominatim geocoding. |
| **HERE** | `geolocation_here` | HERE Maps provider (needs a HERE API key). |
| **Baidu** | `geolocation_baidu` | Baidu Maps provider for sites serving China. |
| **Yandex** | `geolocation_yandex` | Yandex Maps provider for Russia/CIS. |
| **Geocodio** | `geolocation_geocodio` | Geocodio geocoding backend (needs `geocodio/geocodio-library-php`). |
| **Address** | `geolocation_address` | Integrates the `address` field with geolocation and geocoding. |
| **Geofield** | `geolocation_geofield` | Uses `geofield` data in the CommonMap Views style. |
| **Geometry** | `geolocation_geometry` | Geometry-based fields (polygons/lines) and integration. |
| **GPX** | `geolocation_gpx` | GPX file field type/widget/formatter (needs `sibyx/phpgpx`). |
| **Search API** | `geolocation_search_api` | Proximity/location search at scale via Search API. |
| **Demo** | `geolocation_demo` | Example views and pages. **Do not enable in production.** |

For most sites, start by picking one map provider. For example, to use the
open-source Leaflet maps (no key needed):

```bash
drush en geolocation_leaflet -y
```

Or, to use Google Maps (then set your API key at its settings page):

```bash
drush en geolocation_google_maps -y
```

## Verify it worked

Add the `geolocation` field to a content type (see
[Configuration](../configuration/index.md)), set its form-display widget to
**Geolocation Map**, and edit a piece of content — you should be able to drop a
pin on the map. Then set the display formatter to **Map** and view the content to
see the location rendered as an interactive map.
