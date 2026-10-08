<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address suggestion (address_suggestion) — agent index

Adds address autocomplete to the **Address** module (`drupal/address`). As a user types, a JS
autocomplete queries a server-side JSON route, which calls one external geocoding provider
(Nominatim, Photon, Google, Here, Mapbox, TomTom, France/Vietnam/Canada/Swiss post, …) and returns
address parts that pre-fill the address subfields. Also adds a text/string autocomplete widget, a
geofield widget, a country-by-continent widget, two map field formatters, a CKEditor 5 toolbar
button, and a Views Bulk Operations action.

- Depends on: `address:address`. Optional integrations (soft): `geofield`, `geolocation`,
  `views_bulk_operations` (only loaded when those modules exist).
- Core: `^9.2 || ^10 || ^11 || ^12`. Package: `Field types`.
- No dedicated settings page / `configure` route. **All configuration is per field-widget** (form
  display) or per text-format (CKEditor plugin). Provides config schema, no permissions, no drush.
- Defines one plugin type: **`AddressProvider`** (manager `plugin.manager.address_provider`).

## What you'd do → where

- **Turn on autocomplete for an Address field / choose a provider + API key** →
  [configure/widgets.md](configure/widgets.md)
- **Autocomplete a plain text/string field, a geofield, or filter countries by continent** →
  [configure/widgets.md](configure/widgets.md)
- **Add the CKEditor 5 "Address suggestion" button / autocomplete a custom `#autocomplete` textfield** →
  [configure/ckeditor.md](configure/ckeditor.md)
- **Write a custom geocoding provider (or alter the bundled ones)** →
  [plugins/address-provider.md](plugins/address-provider.md)
- **Display an address/geofield value as a map** → [fields/formatters.md](fields/formatters.md)
- **Call the lookup service from code / understand the routes, controller and VBO action** →
  [api/services.md](api/services.md)

## Key facts (real machine names)

- Routes: `address_suggestion.addresses` (`/address/suggestion/{entity_type}/{bundle}/{field_name}`),
  `address_suggestion.ckeditor` (`/address/suggestion/{format}`) — controller
  `Drupal\address_suggestion\Controller\AddressSuggestion` (`handleAutocomplete`, `ckeditor`).
- Services: `plugin.manager.address_provider` (`AddressProviderManager`),
  `address_suggestion.query_services` (`QueryService`).
- Field widgets: `address_suggestion` (address), `address_suggestion_widget` (text/string),
  `address_geofield_default` (geofield), `country_continent` (address_country).
- Field formatters: `address_map` (geofield), `address_suggestion_map` (address).
- Render element: `address_suggestion` (`Element\AddressSuggestion`, extends the address element).
- Plugin type: attribute `Drupal\address_suggestion\Attribute\AddressProvider`, annotation
  `…\Annotation\AddressProvider`, interface `AddressProviderInterface`, base `AddressProviderBase`,
  dir `Plugin/AddressProvider`, alter hook `address_suggestion_provider_info`.
- Bundled provider ids: `nominatim`, `photon`, `france_address`, `vnpost`, `google_place`,
  `google_maps`, `here`, `tomtom`, `map_quest`, `mapbox_geocoding`, `graph_hopper`,
  `distance_matrix`, `bing_maps`, `capost`, `post_ch`.
- Widget setting keys: `provider`, `endpoint`, `api_key`, `username`, `password`, `location_field`,
  `hide`. CKEditor plugin id: `address_suggestion_plugin` (adds a `token`).
- Action plugin: `address_suggestion_action` (VBO — geocode an address field into a geo field).
