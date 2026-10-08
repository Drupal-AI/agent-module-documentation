<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Geo Address - agent index

Shows the visitor's **address in a block** via Google reverse-geocode. Version **2.1.0**, core `^8 || ^9 || ^10`.

- Block `user_geo_address_block`; controller route `user_geo_address.location` at `/get-address/{latitude}/{longitude}` -> `GeoLocation::getUserLocation` -> `UserGeoClient::userAddress` (Google Geocoding API, `verify => TRUE`).
- API key in config `user_geo_address.apiconfiguration` (`google_api_key`); settings form route `user_geo_address.settings`, permission `administer site configuration`.
- SECURITY: `/get-address/...` is gated only by `access content` (effectively anonymous) and consumes the site's Google API key/quota. See findings.