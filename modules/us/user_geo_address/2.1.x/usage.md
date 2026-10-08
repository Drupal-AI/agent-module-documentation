<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Geo Address shows the current user's address in a block by reverse-geocoding browser coordinates through Google Maps.

---

User Geo Address provides a `user_geo_address_block` block that attaches JS to read the browser's geolocation, and a controller route `/get-address/{latitude}/{longitude}` (permission `access content`) that calls the `UserGeoClient` service. That service issues an HTTPS request (`verify => TRUE`) to the Google Maps Geocoding API using the API key stored in `user_geo_address.apiconfiguration` and returns the formatted address as JSON. The API key is configured on `/admin/config/services/usergeoaddress` (permission `administer site configuration`). Because the reverse-geocode endpoint is gated only by `access content` it is reachable anonymously and each call consumes the site's Google API key/quota - see findings.

---

- Show the current visitor's address in a block.
- Reverse-geocode latitude/longitude to an address.
- Use the Google Maps Geocoding API.
- Store the Google API key in module config.
- Configure the key on the admin settings form.
- Return the formatted address as JSON.
- Read the browser geolocation via attached JS.
- Expose a /get-address/{lat}/{long} endpoint.
- Call Google over HTTPS with certificate verification.
- Cache the HTTP client's data (cache.data).
- Display location-aware content to users.
- Personalize a block by visitor location.
- Log HTTP client errors on failure.
- Place the address block in any region.
- Integrate Google geocoding without custom code.
