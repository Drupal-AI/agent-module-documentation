<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Address Autocomplete adds a type-ahead lookup to the Address module's field: a user types part of the street, picks a suggestion, and Drupal fills the address subfields (street, postcode, locality, administrative area) from a geocoding provider. The browser talks only to a Drupal route, which proxies the query server-side to the configured provider (Swiss Post, Google Places, Mapbox, or the French BAN), so the provider credential stays on the server.

---

Typing an address is one of the highest-friction, lowest-accuracy things a form asks of anyone: several fields, a format that differs by country, and a person on a phone who abbreviates, misspells the street and formats the postcode unexpectedly, so the data arrives inconsistent and a shop discovers it when a delivery fails. This module replaces most of that with one interaction — type a few characters, choose, and the fields fill from a source that has the address right. Mechanically it ships an `address_autocomplete` field widget (a subclass of Address's own widget) and a matching form element that swaps `address_line1` for a core `#autocomplete` field. As the user types, core autocomplete calls a Drupal route (`/admin/address_autocomplete/addresses`), whose controller hands the query to the **active provider plugin**; the plugin makes the server-side HTTP call to the provider's API with the site's stored key/credentials and returns JSON suggestions. Google Places uses a two-step flow (autocomplete returns a `place_id`, then a second `/address_details` route fetches the components) with a per-session token to control billing. Four providers ship — **Swiss Post** (HTTP Basic auth, test/integration/production modes), **Google Maps/Places** (API key), **Mapbox Geocoding** (access token), and **France Address / BAN** (no key) — and the provider layer is a plugin type (`AddressProvider`), so a custom provider is just a subclass of `AddressProviderBase`. Version **1.0.0-beta6** on core `^10.1 || ^11`, requiring `address ^1.7 || ^2.0`. Three things to plan. **The provider is a contract and a cost** — address data is licensed, paid per lookup or free with limits, and a request per keystroke multiplies that; the ship-with providers do not debounce or enforce a minimum length for you. **What the user types is sent to the provider** — the beginning of a person's home address — which is a disclosure that belongs in the privacy notice. And **the manual path must remain**: no address database is complete, new-build and unusual addresses are missing from all of them, so the field must still accept a freely typed value.

---

- Autocomplete a delivery address at checkout.
- Fill address subfields from a chosen suggestion.
- Look up a Swiss address via the Swiss Post API.
- Look up an address with Google Places.
- Look up an address with Mapbox Geocoding.
- Look up a French address via the Base Adresse Nationale (no API key).
- Reduce address-entry errors on a mobile form.
- Speed up a registration or membership form.
- Standardise stored address formats across a site.
- Reduce failed deliveries and mailing bounces.
- Country-filter suggestions to the selected country.
- Add autocomplete to a Webform address element.
- Switch the address widget on an existing field to autocomplete.
- Offer autocomplete on a booking or event form.
- Improve a checkout's address step without custom JS.
- Add a custom geocoding provider by extending the plugin base.
- Populate latitude/longitude context from Mapbox results.
- Keep the provider API key server-side (proxy model).
- Reduce support calls about wrong addresses.
- Localise suggestions to the user's current language.
