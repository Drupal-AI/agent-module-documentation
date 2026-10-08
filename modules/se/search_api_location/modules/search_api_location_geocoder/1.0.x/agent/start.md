<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Location Geocoder — agent index

Adds one Search API Location **Location Input** plugin, `geocode` ("Geocoded input"), that
geocodes a typed **address** to `lat,lon` (via the contrib **Geocoder** module) before a
proximity search. No config UI of its own — you pick "Geocoded input" wherever a Location Input
is chosen (e.g. a `search_api_location_views` filter) and configure which geocoder providers it
uses.

- **The `geocode` Location Input plugin, its config, geocoder providers, requirements** →
  [plugins/geocode-input.md](plugins/geocode-input.md)

Key facts:
- Plugin: `@LocationInput(id="geocode", label="Geocoded input")`,
  `search_api_location_geocoder\Plugin\search_api_location\location_input\Geocode`, extends
  `LocationInputPluginBase`, `ContainerFactoryPluginInterface`. Injects `geocoder`,
  `config.factory`, and the `geocoder_provider` entity storage.
- `getParsedInput($input)` geocodes `$input['value']` with the enabled providers (checked,
  ordered by weight; first valid result wins) and returns `"lat,lon"` (or NULL).
- Config: a table of `geocoder_provider` entities as checkboxes + weights (stored inside the host
  filter/facet config, e.g. schema `plugin-geocode` in `search_api_location_views`).
- Requires the **geocoder** module and at least one configured **`geocoder_provider`** entity to
  be useful (many providers call external services). No permissions, no Drush, no config schema
  of its own.
