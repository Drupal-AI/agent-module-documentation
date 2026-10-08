# Using the adresse.data.gouv.fr provider

This module adds a provider to Geocoder; it has **no settings of its own**. You configure it
through the host Geocoder module.

## Enable and select the provider

1. `drush en datagouvfr_geocoder -y` (Geocoder is a hard dependency).
2. Go to the Geocoder providers admin (`/admin/config/system/geocoder/providers`, route
   `geocoder.geocoder_provider.collection`) and add/enable a provider of type
   **adresse.data.gouv.fr** (plugin id `adress_data_gouv_fr`). There are no per-provider
   options (no key, no base-URL override).
3. Reference that provider from a Geocoder field widget/formatter, or from another module that
   consumes Geocoder provider chains.

## What the handler does

`src/Geocoder/Provider/AdressDataGouv` (a geocoder-php `AbstractProvider`) is invoked by
Geocoder:

- **Forward** (`geocodeQuery`): `GET https://api-adresse.data.gouv.fr/search/?limit=1&q=<urlencoded address>`.
- **Reverse** (`reverseQuery`): `GET https://api-adresse.data.gouv.fr/reverse/?lon=<lng>&lat=<lat>`.
- Parses the first GeoJSON `features[0]` into a geocoder `Address`:
  `latitude`, `longitude` (from `geometry.coordinates` `[lon, lat]`), `streetNumber`
  (`housenumber`), `streetName` (`street`), `locality` (`city`), `postalCode` (`postcode`),
  and constant `country`/`countryCode` = `FR`, `timezone` = `Europe/Paris`.
- Only the first result is ever returned (`limit=1`). No match → throws
  `Geocoder\Exception\CollectionIsEmpty`. Undecodable response → `HttpException`.

## Constraints to plan around

- **France only.** The BAN dataset covers French addresses; anything else resolves empty.
- **No API key**, service is open and free.
- **No rate limiting in this module.** Upstream limits are 50 requests/second and 2 concurrent
  requests per IP (see the API FAQ). Throttle bulk/import jobs yourself.
- Base URL is fixed in code — to point at a proxy/mirror you must patch the handler.
