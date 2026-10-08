<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Address Autocomplete Suggestion provides an Address-field widget that suggests full addresses as the user types, by querying a configurable third-party geocoding provider through a plugin system.

Use it to speed up and standardize address entry on forms that use the `address` module, choosing the provider that fits your region and budget.

- Custom field widget extending the Address default widget.
- Pluggable `AddressProvider` plugins: Google Maps, Mapbox Geocoding, Post.ch.
- Per-provider settings forms (API key/token or endpoint+credentials).
- JSON autocomplete endpoint returning normalized suggestions.

---

Install and configure:

- Enable `drux en address_autocomplete_suggestion` (requires `address`).
- Choose the active provider at `/admin/config/address-autocomplete-suggestion` (needs `access administration pages`).
- Configure the provider's credentials at `/admin/config/address-autocomplete/<provider>`.
- Set an Address field's widget to "Address autocomplete Suggestion" on Manage form display.
- Verify suggestions appear as you type into address line 1.

---

- The widget swaps the address element type to `address_autocomplete_suggestion` and attaches the autocomplete route/library.
- The endpoint `/admin/address_autocomplete_suggestion/addresses` takes a `q` query param and returns JSON.
- The controller instantiates the active provider plugin and calls `processQuery($q)`.
- Google provider calls the Geocoding API with the site's API key.
- Mapbox provider concatenates the query into the request URL with the site token.
- Post.ch provider POSTs to a configured endpoint with basic-auth credentials.
- Provider config is stored serialized under the plugin id in module config.
- Suggestion results are public geocoding data (not internal data disclosure).
- Providers use Guzzle with default TLS verification (not disabled).
- Normalized fields returned: street_name, town/city, province, zip_code, label.
- Add new providers by implementing `AddressProviderInterface`.
- Keep API keys/tokens out of VCS.
- Monitor provider usage/billing once live.
