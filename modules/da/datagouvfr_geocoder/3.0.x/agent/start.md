# AdressDataGouvFr Geocoder Provider — agent index

Registers one [Geocoder](https://www.drupal.org/project/geocoder) provider plugin,
`adress_data_gouv_fr`, calling the free French `api-adresse.data.gouv.fr` (BAN) service for
forward and reverse geocoding of **French addresses only**. No own config UI (`configure` null),
no permissions, no Drush, no config schema. Depends on `geocoder:geocoder`.

- **Enabling the provider, the endpoints it calls, request/response mapping, limits** →
  [configure/provider.md](configure/provider.md)

Key facts:
- Plugin id `adress_data_gouv_fr` (`src/Plugin/Geocoder/Provider/AdressDataGouv`), label
  "adresse.data.gouv.fr", handler `src/Geocoder/Provider/AdressDataGouv`.
- Base URL hardcoded: `https://api-adresse.data.gouv.fr/`. Forward: `search/?limit=1&q=<address>`.
  Reverse: `reverse/?lon=<lng>&lat=<lat>`. Uses `\Drupal::httpClient()`.
- Returns only the first match; country/countryCode forced to `FR`, timezone `Europe/Paris`.
  Empty/failed lookups throw `CollectionIsEmpty`.
- No API key, no rate limiting in code (upstream: 50 req/s, 2 concurrent per IP).
