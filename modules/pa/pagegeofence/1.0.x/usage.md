<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page Geofence provides geofencing to restrict page access based on the visitor's country, with allow/deny rules and redirect or 403 responses.

---

Page Geofence restricts access to pages based on the visitor's geographic location. Administrators
define rules (config entities) that target pages (exact paths or wildcards), allow or deny by selected
countries, and respond by redirecting to an internal/external URL or showing a 403 — processed in weight
order. It depends on core Field, System and User and is configured at the `pagegeofence_rule` collection;
it provides its own permissions.

Use it for geo-targeting or geo-restriction (regional content, legal/licensing geoblocks). Important
security caveat: **geo-IP restriction is a soft control, not a strong security boundary.** It relies on
IP-to-country geolocation, which users can bypass with a VPN/proxy, and on the correct client IP
(configure trusted proxies so a CDN/proxy doesn't mask or let visitors spoof the source IP). Treat it as
a policy/UX geoblock (e.g. showing region-appropriate content or meeting a licensing requirement), not
as protection for truly sensitive content — for that, use real access control. Define rules carefully so
they don't accidentally block intended visitors.

---

- Restrict page access by country.
- Define geofencing rules.
- Allow or deny by visitor country.
- Target pages with paths or wildcards.
- Redirect or 403 blocked visitors.
- Process rules by weight.
- Depend on Field, System, User.
- Configure at the pagegeofence_rule collection.
- Provide its own permissions.
- Geo-target regional content.
- Meet licensing geoblock requirements.
- Know geo-IP is bypassable (VPN).
- Configure trusted proxies for real IP.
- Treat as a soft control, not security.
- Use real access control for sensitive content.
- Avoid blocking intended visitors.
- Restrict by geography.
- Redirect by country.
- Apply geoblocks.
- Show region-appropriate pages.
