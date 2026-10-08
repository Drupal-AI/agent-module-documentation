<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Autocomplete Suggestion — agent orientation

Address-field autocomplete widget backed by pluggable geocoding providers.

Key files:
- `src/Controller/AddressAutocompleteSuggestion.php` — `handleAutocomplete()` reads `q`, runs the active provider's `processQuery()`, returns JSON.
- `*.routing.yml` — endpoint `address_autocomplete_suggestion.addresses` (`/admin/address_autocomplete_suggestion/addresses`); admin routes require `access administration pages`.
- `src/Plugin/AddressProvider/{GoogleMaps,MapboxGeocoding,PostCh}.php` — Guzzle calls (default TLS, not disabled) using stored keys/credentials.
- `src/Plugin/AddressProviderBase.php` — `new Client()`, unserializes provider config from module config (admin-set).
