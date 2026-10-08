# Permissions — Geocoder Autocomplete

Source: `geocoder_autocomplete.permissions.yml` / `geocoder_autocomplete.routing.yml`.

| Permission | Gates |
|---|---|
| `access geocoder autocomplete` | Access to the `/geocoder/autocomplete` lookup route **and** whether the field widget attaches the autocomplete behaviour (`GeocoderAutocomplete::formElement()` checks this before adding `#autocomplete_route_name`). |
| `administer geocoder autocomplete` | Access to the settings form at `/admin/config/system/geocoder_autocomplete` (API key + region bias). |

Notes:

- The lookup route requires `access geocoder autocomplete`, so anonymous/low-trust users cannot
  hit the endpoint (and thus cannot consume the site's Google API quota) unless granted it.
- Grant `access geocoder autocomplete` to the roles that edit address fields; keep
  `administer geocoder autocomplete` to trusted admins (it holds the API key form).
- Neither permission sets `restrict access: true`; both are ordinary grantable permissions.
