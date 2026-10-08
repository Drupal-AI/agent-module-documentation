<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Geocoder — agent index

Provides a **Geocoder computed field for Webform** (geocodes an address to coordinates). Depends on `webform`,
`geocoder`. Version **1.0.2**. Core `^9||^10||^11`.

Forms/integration — sends the **address to the configured Geocoder provider** (egress; API key in Geocoder as a
secret, HTTPS); address/coordinates are personal data. No access role.
