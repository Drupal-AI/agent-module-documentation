<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform GeoIP Restriction allows you to restrict access to a webform depending on the country, using GeoIP lookup.

---

Webform GeoIP Restriction restricts access to webforms by country — using a GeoIP lookup of the
visitor's IP to allow or deny access to a webform based on the resolved country, so a form can be limited to
(or blocked from) specific countries. It depends on the Webform and GeoIP modules and provides Drush
commands, in the Webform package.

Use it to geo-restrict webform submissions. It is an access-restriction feature for webforms. Important
caveat about GeoIP-based access: **GeoIP is best-effort, not a strong security boundary** — country
resolution can be wrong, and users behind VPNs/proxies/Tor can trivially appear to be in an allowed country,
so treat this as a soft/compliance filter (reduce unwanted submissions, meet a jurisdictional preference),
**not** as protection for sensitive data. Also ensure the GeoIP source uses the correct client IP (behind a
reverse proxy, trusted-proxy/`X-Forwarded-For` handling must be configured, or the country reflects the
proxy). It has no other access-control role. Configure the allowed/blocked countries per webform.

---

- Restrict webforms by country.
- Allow/deny access via GeoIP.
- Limit a form to specific countries.
- Depend on Webform and GeoIP.
- Provide Drush commands.
- Look up the visitor's country by IP.
- Treat GeoIP as best-effort, not strong security.
- Know VPN/proxy users can bypass it.
- Not use it to protect sensitive data.
- Ensure the correct client IP is used.
- Configure trusted-proxy handling behind a proxy.
- Configure allowed/blocked countries.
- Reduce unwanted submissions.
- Use as a soft/compliance filter.
- Geo-restrict submissions.
- Handle country restriction.
- Restrict form access.
- Configure per webform.
- Filter by country.
- Limit webform access.
