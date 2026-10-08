<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform GeoIP Restriction — agent index

Restricts **access to a webform by the visitor's country (GeoIP)** (allow/deny by resolved country). Depends
on `webform`, `geoip`; Drush commands. Version **1.1.8**. Core `>=8`.

Access-restriction for webforms. **Caveat:** GeoIP is **best-effort, not a strong boundary** — VPN/proxy/Tor
users bypass it, resolution can be wrong; treat as a soft/compliance filter, not protection for sensitive
data. Ensure correct client IP behind a reverse proxy (trusted-proxy/XFF). Configure allowed/blocked
countries.
