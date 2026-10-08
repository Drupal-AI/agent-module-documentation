# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Geo Entity** module (`geo_entity`) — this is where the location entity type
  actually lives since version 2. It is a required dependency and Composer installs it
  for you.

**For UK Ordnance Survey Places geocoding (optional):** you additionally need the
`localgovdrupal/localgov_os_places_geocoder_provider` Composer package and an Ordnance
Survey Places API key. This is free for UK local authorities. Without it, the module
falls back to OpenStreetMap geocoding, which needs no key.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_geo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Geo Entity and update
any shared dependencies as needed.

To add the UK geocoder provider as well:

```bash
composer require localgovdrupal/localgov_os_places_geocoder_provider -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_geo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module and the bundles you need

```bash
drush en localgov_geo -y

# Then enable the location bundles you want:
drush en localgov_geo_address -y   # points with a structured address
drush en localgov_geo_area -y      # polygon areas / boundaries
```

The base module supplies the wrapper and defaults; the **address** and **area**
submodules are what give you actual location bundles to create records in.

## After enabling

Remember that install grants the **View geo** permission to anonymous and authenticated
users on purpose (so locations appear in Search API results) — see the
[overview](../index.md#how-to-use-it) for why, and only revoke it if you specifically
need location data hidden.

### Setting up the UK geocoder

If you installed the Ordnance Survey Places package, configure it as a provider in the
**Geocoder** module's settings and supply your API key there — LocalGov Geo ships the
plugin but the provider configuration lives in Geocoder. (A known Geocoder quirk: a
newly added provider sometimes doesn't appear in the *Geocoder provider* dropdown until
PHP is restarted.)
