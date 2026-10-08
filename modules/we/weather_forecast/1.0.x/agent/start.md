<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Weather Forecast — agent index

**Displays the weather forecast based on region**. Depends on core `block`, `geolocation`. Version **1.0.5**. Core
`^10||^11`.

Integration/content-display — calls an external **weather API** (egress) with an **API key** (secret — env/Key,
HTTPS); visitor location = location data (consent/disclose). No access role.
