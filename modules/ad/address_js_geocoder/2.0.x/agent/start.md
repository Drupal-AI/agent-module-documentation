<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address js geocoder (address_js_geocoder) — agent index

**Adds an `address_geocoder` field widget that geocodes an address over AJAX and fills a target geofield.**

- **Version:** 2.0.x (2.0.0-alpha7)
- **Core:** ^9 || ^10 || ^11
- **Depends:** geofield, geocoder_geofield, geocoder_address, address
- **Key code:** `src/Plugin/Field/FieldWidget/AddressGeocoder.php` (widget, AJAX callbacks), `src/Ajax/GeocodeAddressCommand.php` (client command)
- **No routes / no permissions / no services** — it is purely a field widget.
- **Setup:** on the entity form display pick the "Address geocoder" widget for the address field and set the geofield target machine name; enable geocoding on the geofield.

**Security:** No routes, no anonymous surface. Geocoding runs server-side via the `geocoder` service on authenticated entity forms; the provider API key lives in geocoder provider config and is never sent to the client. No TLS/credential handling in this module.

See [configure/widget.md](configure/widget.md)