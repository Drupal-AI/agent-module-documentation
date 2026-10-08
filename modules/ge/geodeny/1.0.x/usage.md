<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GeoDeny blocks visitors by country: if the client IP resolves to a country in your configured deny list, the response is replaced with an HTTP 400.

---

It registers a response event subscriber (GeoDenyResponseSubscriber) that, on every kernel response, looks up the client IP's country via the ip2country module's lookup service and, if that country is in the configured geoList (config geodeny.settings, form at /admin/config/services/geodeny, perm 'administer site configuration'), swaps in an empty 400 response. Enforcement therefore happens on the RESPONSE event after the controller has run, and it relies on the request's client IP, so a correct reverse-proxy/trusted-proxy configuration is required for the IP to be accurate. It depends on ip2country for the geolocation database and lookup. Use it for coarse country-level access restriction (compliance, sanctions, abuse mitigation); it is not a substitute for a WAF or per-route access control.

---

- Block traffic from specific countries for compliance.
- Deny access to sanctioned regions.
- Reduce abuse originating from particular countries.
- Restrict a site to a set of allowed countries by blocking the rest.
- Add coarse geo-fencing without a WAF.
- Return a 400 to visitors from a blocked country.
- Combine with ip2country's geolocation database.
- Configure the blocked-country list from an admin form.
- Limit content availability by geography.
- Discourage scraping from known bad-actor regions.
- Enforce licensing territory restrictions loosely.
- Apply a site-wide country block via an event subscriber.
- Layer geo-blocking on top of other access controls.
- Quickly toggle regional blocks via configuration.
- Support regulatory geo-restriction requirements.
- Block anonymous crawlers from specific countries.
