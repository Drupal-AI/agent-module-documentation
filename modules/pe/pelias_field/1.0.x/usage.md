<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A geocoding autocomplete field powered by the Pelias API.

---

Pelias Field provides an autocomplete field for geocoding using the Pelias API (geocode.earth or self-hosted) — so an editor types an address and the field autocompletes to a geocoded result (with coordinates) via Pelias, storing structured location data.

The autocomplete endpoint proxies to the admin-configured Pelias service server-side (the API key is not exposed to the client); note the endpoint is open (used for as-you-type autocomplete) so rate-limit if using a paid geocoder. Depends on core `field`, `text`, and `system`; supports Drupal 9, 10, and 11.

---

- Geocode via an autocomplete field.
- Use the Pelias API.
- Support geocode.earth / self-hosted.
- Store geocoded coordinates.
- Proxy to Pelias server-side.
- Not expose the API key to clients.
- Rate-limit a paid geocoder.
- Depend on core `field`, `text`, `system`.
- Support Drupal 9, 10, and 11.
- Configure the connection.
- Handle geocoding.
- Autocomplete addresses
- Support Drupal.
- Support Drupal.
- Support Drupal.
