<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Autocomplete (address_autocomplete) — agent index

Type-ahead lookup for the **Address** module's field. Type part of a street, pick a suggestion,
and Drupal fills the address subfields from a geocoding provider. Requires `address` (`^1.7 || ^2.0`)
— the right base, since it already handles the per-country subfield format the results populate.
Version **1.0.0-beta6** (beta, not security-advisory covered). Core `^10.1 || ^11`.
Configure at `/admin/config/address-autocomplete` (permission: `administer address autocomplete`).

## How it works (real mechanism)

- **Widget + element.** `AddressAutocompleteWidget` (a subclass of Address's `AddressDefaultWidget`,
  id `address_autocomplete`, for `address` fields) swaps the render element to `address_autocomplete`
  (`src/Element/AddressAutocomplete.php`, a subclass of Address's `Address` element). Its `#process`
  puts a core `#autocomplete_route_name` on `address_line1` and attaches a JS library. A matching
  Webform element (`Plugin/WebformElement/AddressAutocomplete.php`) exists when `webform` is present.
- **Server-side proxy, not a browser-to-API call.** As the user types, core autocomplete calls the
  Drupal route `address_autocomplete.addresses` (`/admin/address_autocomplete/addresses?q=…&country=…&session_token=…`).
  `Controller/AddressAutocomplete::handleAutocomplete()` packs the params into a `q||country||token`
  string and calls the **active provider plugin**'s `processQuery()`, which makes the outbound HTTPS
  call (Guzzle `http_client`) using the site's stored credential, and returns JSON suggestions.
- **Google two-step.** For Google the autocomplete returns a `place_id`; picking a suggestion has the
  browser (`js/google_maps.js`) call a second route `address_autocomplete.address_details`
  (`/admin/address_autocomplete/address_details`) → `handleAddressDetails()` →
  `processAddressDetailsQuery()` (Places Details API). A per-session UUID token groups the requests
  for billing. Other providers return the full components in one call and `js/address_autocomplete.js`
  fills the subfields directly.
- **Provider plugin type.** `AddressProvider` annotation plugins, managed by
  `plugin.manager.address_provider`, base class `AddressProviderBase`. Ships four:
  `post_ch` (Swiss Post, HTTP Basic auth, `mode` = test/integration/production), `google_maps`
  (API key), `mapbox_geocoding` (access token), `france_address` (French BAN, no key). Add one by
  extending `AddressProviderBase`.
- **Config.** All settings live in `address_autocomplete.settings`: `active_plugin` plus a per-plugin
  mapping holding that provider's credential. Selected on the settings form; each provider has its own
  settings form at a dynamically-registered route (`Routing/AddressProviderRoutes`).

## Files worth reading

- `src/Controller/AddressAutocomplete.php` — the two proxy endpoints.
- `src/Plugin/AddressProvider/*.php` — one file per provider; the actual upstream API calls.
- `src/Element/AddressAutocomplete.php` / `src/Plugin/Field/FieldWidget/AddressAutocompleteWidget.php` — how the field is wired.
- `agent/api/providers.md` — the provider plugin system, routes, and how to add a provider.
- `agent/config/settings.md` — configuration and where each credential is stored.

## Three things to plan

1. **The provider is a contract and a cost.** Address data is licensed — paid per lookup or free with
   limits — and a request per keystroke multiplies that. The shipped widget does **not** debounce or
   enforce a minimum length; core autocomplete's own delay/min-length is all you get out of the box.
2. **What the user types is sent to the provider** — the start of a person's home address. That is a
   disclosure and belongs in the privacy notice.
3. **The manual path must remain.** No address database is complete (new-build and unusual addresses
   are missing from all of them), so keep the field accepting a freely typed value.
