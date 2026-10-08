<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Country Block denies access to the whole site for visitors whose GeoIP-resolved country (via Smart IP) is on an admin-configured blocklist.

---

Country Block adds a kernel request subscriber (`CountryBlockSubscriber`, priority 10) that runs on every main request, reads the visitor's country code from the Smart IP location service (`smart_ip.smart_ip_location`), and — if that code is in the configured `blocked_countries` list — throws an `AccessDeniedHttpException` carrying an admin-configured message. Users holding `administer site configuration` are skipped, so administrators cannot be locked out. The blocklist (two-letter ISO 3166-1 alpha-2 codes) and the denial message are edited on a single settings form at `/admin/config/people/country-block`, gated by the module's own `administer country block` permission and stored in the `country_block.settings` config object. It depends on the Smart IP module, which does the actual IP-to-country resolution and must have a working data source (e.g. a GeoIP database). Country blocking is a coarse, best-effort gate: GeoIP is approximate and a client IP can be changed via VPN/proxy, so treat it as compliance/UX geo-gating rather than a strong security boundary or the only access control on sensitive content.

---

- Block all site access for visitors from specific countries.
- Restrict content by region for licensing compliance.
- Enforce legal/regulatory geo-restrictions on a site.
- Reduce malicious or abusive traffic from particular countries.
- Maintain a simple editable blocklist of ISO 3166-1 alpha-2 codes.
- Show a custom denial message to blocked visitors.
- Resolve visitor country from IP via the Smart IP module.
- Exempt administrators (holders of `administer site configuration`) from the block.
- Delegate the settings page to a dedicated `administer country block` permission.
- Grant only trusted roles the ability to edit the blocklist.
- Add or remove blocked countries without code changes.
- Apply a site-wide block on every request (all routes/paths).
- Pair with a maintained GeoIP database for accurate detection.
- Configure trusted reverse proxies (in Smart IP / Drupal) so client-IP detection is reliable behind a proxy or CDN.
- Store the blocklist and message as exportable configuration (`country_block.settings`).
- Deploy the blocklist across environments via config sync.
- Combine with other access controls (do not rely on it alone for sensitive data).
- Temporarily geo-block during an incident by adding country codes.
- Clear the blocklist to disable blocking without uninstalling.
- Customize the denial wording per site (legal notice, contact info).
- Serve a lightweight, single-purpose alternative to broader geolocation suites.
