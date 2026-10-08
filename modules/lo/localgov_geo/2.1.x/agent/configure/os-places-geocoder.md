# Ordnance Survey Places geocoder provider

`localgov_geo` ships one thing you configure: a **Geocoder provider plugin** for the UK Ordnance
Survey (OS) Places API, used for address lookup / geocoding of UK addresses and postcodes. It is a
plugin FOR the contrib `geocoder` module — this module has no settings form or route of its own.

- Plugin class: `Drupal\localgov_geo\Plugin\Geocoder\Provider\LocalgovOsPlacesGeocoder`
  (file `src/Plugin/Geocoder/Provider/LocalgovOsPlacesGeocoder.php`).
- Annotation: `@GeocoderProvider(id = "localgov_os_places", name = "LocalGov OS Places", ...)`.
- Base class: geocoder's `ConfigurableProviderUsingHandlerWithAdapterBase` (the plugin body is
  empty — behaviour comes from the base class + the handler below).
- Lookup handler: `\LocalgovDrupal\OsPlacesGeocoder\Provider\OsPlacesGeocoder`, provided by the
  **external** Composer package `localgovdrupal/localgov_os_places_geocoder_provider` (a `suggest`,
  version `1.x-dev`) — NOT bundled in this module. The HTTP request to the OS API is performed by
  that package, not by this module.

## Prerequisites

1. `composer require localgovdrupal/localgov_os_places_geocoder_provider` (per the composer suggest).
2. An OS Data Hub API key — free for UK local authorities (see https://osdatahub.os.uk/docs/places/overview).
3. The `geocoder` module enabled (this is how the provider is configured/consumed).

## Configuration entity and schema

A provider is a `geocoder.geocoder_provider.<machine_name>` config entity with `plugin: localgov_os_places`
and a `configuration:` mapping validated by the schema
`geocoder_provider.configuration.localgov_os_places` (file `config/schema/localgov_geo.schema.yml`):

| Key | Type | Default (plugin annotation) | Purpose |
|-----|------|-----------------------------|---------|
| `apiKey` | string | `""` (empty) | OS Data Hub API key. |
| `genericAddressQueryUrl` | string | `https://api.os.uk/search/places/v1/find` | REST endpoint for address lookup (street names AND postcodes). |
| `postcodeQueryUrl` | string | `https://api.os.uk/search/places/v1/postcode` | REST endpoint for postcode-only lookup. |
| `throttle.period` | integer | (unset) | Rate-limit window, in seconds. `throttle` mapping is nullable. |
| `throttle.limit` | integer | (unset) | Max requests allowed per window. |
| `userAgent` | string | `LocalGov Drupal` | User-Agent sent with API requests. |

## Create / configure it

UI: `/admin/config/system/geocoder/geocoder-provider` → add a provider, pick **LocalGov OS Places**,
paste the API key, save. (If "LocalGov OS Places" is missing from the dropdown, restart PHP — a known
geocoder-module plugin-discovery quirk noted in the README.) Then reference the provider from any
Geocoder field/handler config.

Set the API key on an existing provider (machine name `os_places` here) with Drush:

```bash
drush config:set geocoder.geocoder_provider.os_places configuration.apiKey 'YOUR_OS_KEY'
```

…or in PHP:

```php
$provider = \Drupal::configFactory()->getEditable('geocoder.geocoder_provider.os_places');
$provider->set('configuration.apiKey', 'YOUR_OS_KEY');
// Optional throttle:
$provider->set('configuration.throttle.period', 60);
$provider->set('configuration.throttle.limit', 100);
$provider->save();
```

The default endpoints already point at the live OS API, so only `apiKey` is required for a working
UK geocoder.
