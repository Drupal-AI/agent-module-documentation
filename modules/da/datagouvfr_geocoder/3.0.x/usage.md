Adds a France-only geocoding provider to the [Geocoder](https://www.drupal.org/project/geocoder) module, backed by the free official `adresse.data.gouv.fr` (Base Adresse Nationale) web service.

---

The module registers a single Geocoder provider plugin, `adress_data_gouv_fr` ("adresse.data.gouv.fr"), by subclassing `ProviderUsingHandlerBase`; the real work lives in a plain PHP handler (`src/Geocoder/Provider/AdressDataGouv`) extending the geocoder-php `AbstractProvider`. It supports both forward geocoding (address string → coordinates) via `GET https://api-adresse.data.gouv.fr/search/?limit=1&q=<address>` and reverse geocoding (lat/lng → address) via `GET .../reverse/?lon=&lat=`. The endpoint base URL is hardcoded, so there is nothing to configure in the module itself: you enable the provider inside Geocoder's own settings (or a geocoder-based field/formatter/widget) and this provider becomes selectable. Each call returns only the first result (`limit=1` / first feature), mapped into a geocoder `Address` with latitude, longitude, house number, street, city, postcode, and country hardcoded to `FR` / timezone `Europe/Paris`. There is no API key (the service is open) and the module codes no rate limiting — the upstream API allows 50 req/s and 2 concurrent requests per IP, which is the operator's responsibility to respect. It only resolves French addresses; other locales return empty collections (a `CollectionIsEmpty` exception). No admin UI, no permissions, no Drush, no config schema of its own.

---

- Geocode French postal addresses to latitude/longitude without a paid provider or API key.
- Reverse-geocode coordinates captured from a map widget back into a French street address.
- Populate a Geofield/geolocation field from a text address field using Geocoder's field integration.
- Add `adresse.data.gouv.fr` as a fallback or preferred provider in a Geocoder provider chain.
- Normalize user-entered French addresses (autocomplete/cleanup) against the official BAN dataset.
- Store house number, street, city, and postcode parsed from a single address string.
- Build a store locator or "find nearest branch" feature scoped to France.
- Attach coordinates to content on save via a Geocoder-enabled field widget.
- Display a map marker for an address entered as plain text.
- Validate that an address exists in the French national address base before accepting a submission.
- Enrich imported/migrated French address data with coordinates during a Feeds or Migrate run (through Geocoder).
- Provide a GDPR-friendly, self-sovereign geocoding option hosted by the French government rather than a US cloud provider.
- Use a free provider for development/staging to avoid burning paid Google/Mapbox quota.
- Reverse-geocode GPS points from a mobile submission into a human-readable address.
- Resolve a postcode-only or partial address to its best match (first result).
- Combine with Leaflet/Geofield map modules to plot geocoded French content.
- Swap an existing paid geocoder for the free BAN service on French-only sites.
- Batch-geocode a taxonomy of French locations for faceted/proximity search.
- Provide address autocomplete data sourced from an authoritative government dataset.
- Set a consistent `Europe/Paris` timezone on all geocoded results.
