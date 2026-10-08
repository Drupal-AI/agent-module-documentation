<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AddressProvider plugin type, proxy routes & adding a provider

## Plugin type

- **Annotation:** `Drupal\address_autocomplete\Annotation\AddressProvider` (`@AddressProvider`, keys `id`, `label`).
- **Manager service:** `plugin.manager.address_provider` (`AddressProviderManager`, discovers `Plugin/AddressProvider`, alter hook `address_autocomplete_address_provider_info`).
- **Interface:** `AddressProviderInterface` — `processQuery($string)` and `processAddressDetailsQuery($address_id, $session_token = NULL)`. Extends `ConfigurableInterface`, `PluginFormInterface`, `ContainerFactoryPluginInterface`.
- **Base class:** `AddressProviderBase` — injects Guzzle `http_client` (`$this->client`) and the `logger.channel.address_autocomplete` logger. Its `create()` auto-loads the plugin's runtime config from `address_autocomplete.settings.<plugin_id>` when instantiated with an empty configuration array, so a provider reads its own credential from `$this->configuration[...]`.

## Shipped providers

| Plugin id | Label | Upstream (fixed host) | Credential | Notes |
|---|---|---|---|---|
| `post_ch` | Post CH | `webservices[-int].post.ch` (host chosen from a fixed 3-entry map by `mode`) | `username` + `password` (HTTP Basic) | POST JSON; results filtered through `Xss::filter`; capped at 10; guesses house number from the last token. |
| `google_maps` | Google Maps | `maps.googleapis.com/maps/api/place/autocomplete/json` + `/details/json` | `api_key` | Two-step (place_id → details); `sessiontoken` per session; `location=0,0` to defeat server-IP bias. |
| `mapbox_geocoding` | Mapbox Geocoding | `api.mapbox.com/geocoding/v5/mapbox.places/` | `token` (access_token) | Query `rawurlencode`d into the path; returns lat/long context too. |
| `france_address` | France Address | `data.geopf.fr/geocodage/search` (French BAN) | none | No configuration/credential. |

All upstream URLs are hard-coded `https://` constants; there is **no** admin-supplied endpoint that is fetched (the `post_ch` host comes from a fixed whitelist keyed by `mode`). Outbound calls use the Guzzle client's default TLS verification.

## Proxy routes (`address_autocomplete.routing.yml`)

- `address_autocomplete.addresses` → `AddressAutocomplete::handleAutocomplete` (JSON). The type-ahead endpoint. Query params `q`, `country`, `session_token` are joined as `q||country||session_token` and passed to the active plugin's `processQuery()`.
- `address_autocomplete.address_details` → `AddressAutocomplete::handleAddressDetails` (JSON). Google's second step; params `address_id`, `session_token`.
- Both resolve the active provider from `address_autocomplete.settings.active_plugin` and instantiate it via the manager.
- `route_callbacks` → `AddressProviderRoutes::routes()` dynamically registers `admin/config/address-autocomplete/<plugin-url>` config forms for every provider (`administer address autocomplete`).

## Adding a custom provider

1. Create `src/Plugin/AddressProvider/MyProvider.php`, annotate `@AddressProvider(id = "my_provider", label = @Translation("My provider"))`, extend `AddressProviderBase`.
2. Implement `processQuery($string)`: `explode('||', $string)` to get `[input, country, session_token]`; call your API with `$this->client`; return an array of rows. `js/address_autocomplete.js` reads `label` (dropdown text), `street_name`, `zip_code`, `town_name`, `administrative_area` from each row.
3. Optional: `buildConfigurationForm()` / `submitConfigurationForm()` / `defaultConfiguration()` for a credential; add its shape to `config/schema/address_autocomplete.schema.yml`.
4. Optional: implement `processAddressDetailsQuery()` for a Google-style two-step and attach a JS library that calls the details route.
